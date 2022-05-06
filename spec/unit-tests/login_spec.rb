# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'the login page for mentees' do
  describe 'login validation' do
    it 'redirects to search page after successfull login' do
      register_user
      login_user
      expect(page).to have_content('Search')
      clear_database
    end
    
    it 'cannot login if the account is suspended' do
      suspend_mentee
      login_as_suspended_mentee
      expect(page).to have_content("Your account is suspended")
      clear_database
    end

    it 'unable to login if a field is missing' do
      login_user_missing
      expect(page).to have_content('Username or password are incorrect')
    end

    it 'stops login and shows seperate message if username field not filled in' do
      post '/login', 'password' => 'mentee1'
      expect(last_response.body).to include('Username cannot be empty')
    end

    it 'stops login and shows seperate message if password field not filled in' do
      post '/login', 'username' => 'mentee1'
      expect(last_response.body).to include('Password cannot be empty')
    end
  end
  
  describe 'the user can appeal a suspension' do
    it 'the user sends an appeal email and is redirected to home page' do
      suspend_mentee
      login_as_suspended_mentee
      fill_in 'sender', with: 'mentee1@test.ac.uk'
      click_button 'submit'
      expect(page).to have_content('Get advice and mentorship from industry experts')
    end
  end
  
  describe 'user forgets password and is sent to a page where they can send their email to get their password changed' do
    it 'they are redirected to home page after successfully sending an email ' do
      visit '/login'
      click_link href: '/forgotpassword'
      fill_in 'sender', with: 'mentee1@test.ac.uk'
      click_button 'submit'
      expect(page).to have_content('Get advice and mentorship from industry experts')
    end
  end
end
