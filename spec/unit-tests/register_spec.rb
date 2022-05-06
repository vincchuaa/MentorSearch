# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'the register page for mentees' do
  describe 'register validation' do
    it 'redirects to login page after a successfull registration for mentee' do
      register_user
      expect(page).to have_content('Login to MentorSearch')
      clear_database
    end

    it 'stops registration if more than one fields are not completed' do
      register_user_missing
      expect(page).to have_content('Please correct the information below')
    end

    it 'stops registration and shows seperate message if email field not filled in' do
      post '/register', 'username' => 'mentee1', 'password' => 'mentee1'
      expect(last_response.body).to include('Email cannot be empty')
    end

    it 'stops registration and shows seperate message if username field not filled in' do
      post '/register', 'email' => 'mentee1@sheffield.ac.uk', 'password' => 'mentee1'
      expect(last_response.body).to include('Username cannot be empty')
    end

    it 'stops registration and shows seperate message if password field not filled in' do
      post '/register', 'email' => 'mentee1@sheffield.ac.uk', 'username' => 'mentee1'
      expect(last_response.body).to include('Password cannot be empty')
    end

    it 'stops registration and shows seperate message if UoS email not used' do
      post '/register', 'email' => 'mentee1@gmail.com', 'username' => 'mentee1',
                        'password' => 'mentee1'
      expect(last_response.body).to include('Email must be a permitted University email address.')
    end
    
    it 'stops registration and shows seperate message username is already taken' do
      register_user
      post '/register', 'email' => 'mentee2@sheffield.ac.uk', 'username' => 'mentee1',
                        'password' => 'mentee1'
      expect(last_response.body).to include('Username is already taken')
      clear_database
    end
    
    it 'stops registration and shows seperate message email is already taken' do
      register_user
      post '/register', 'email' => 'mentee1@sheffield.ac.uk', 'username' => 'mentee2',
                        'password' => 'mentee1'
      expect(last_response.body).to include('Email is already taken')
      clear_database
    end
  end
end
