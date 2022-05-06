# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'the login page' do
  describe 'login validation' do
    it "redirects to mentor profile page when a correct email and password is entered" do
      register_mentor
      login_mentor
      expect(page).to have_content('Personal Details')
      clear_database_mentor
    end

    it 'cannot login if the account is suspended' do
      suspend_mentor
      login_as_suspended_mentor
      expect(page).to have_content("Your account is suspended")
      clear_database_mentor
    end
    
    it 'unable to login if a field is missing' do
      loginmentor_user_missing
      expect(page).to have_content('Username or password are incorrect')
    end

    it 'stops login and shows seperate message if username field not filled in' do
      post '/login', 'password' => 'testpass'
      expect(last_response.body).to include('Username cannot be empty')
    end

    it 'stops login and shows seperate message if password field not filled in' do
      post '/login', 'username' => 'testuser'
      expect(last_response.body).to include('Password cannot be empty')
    end
  end
  
  describe 'logout validation' do
    it 'returns to the landing page when logging out' do
      login_mentor
      visit '/logout_mentor'
      expect(page).to have_content('Get advice and mentorship from industry experts')
    end
  end
  
end
