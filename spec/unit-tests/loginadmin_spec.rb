# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'the login page for admins' do
  describe 'login validation' do
    it 'redirects to search page after successfull login' do
      #clearing databases
      clear_database
      clear_database_mentor
      login_admin
      expect(page).to have_content('User search')
      clear_database
    end

    it 'unable to login if wrong username is entered' do
      post '/loginadmin', 'username' => 'WrongUsername', 'password' => 'password'
      expect(last_response.body).to include('Username or password are incorrect.')
    end
    
    it 'unable to login if wrong password entered' do
      post '/loginadmin', 'username' => 'admin', 'password' => 'wrongPassword'
      expect(last_response.body).to include('Username or password are incorrect.')
    end

    it 'stops login and shows seperate message if username field not filled in' do
      post '/loginadmin', 'password' => 'admin'
      expect(last_response.body).to include('Username cannot be empty')
    end

    it 'stops login and shows seperate message if password field not filled in' do
      post '/login', 'username' => 'admin'
      expect(last_response.body).to include('Password cannot be empty')
    end
  end
end