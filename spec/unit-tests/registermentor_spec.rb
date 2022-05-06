# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'the register page for mentors' do
  describe 'register validation' do
    it 'redirects to login page after a successful registration for mentor' do
      clear_database_mentor
      register_mentor
      expect(page).to have_content('Login to MentorSearch')
      clear_database_mentor
    end

    it 'stops registration if more than one fields are not completed' do
      register_mentor_missing
      expect(page).to have_content('Please correct the information below')
    end

    it 'stops registration and shows seperate message if first name field not filled in' do
      post '/registermentor', 'lastname' => 'mentor1Lname', 'email' => 'mentor1@email.com',
                              'username' => 'mentor1', 'password' => 'mentor1', 'domain' => 'COMP'
      expect(last_response.body).to include('First Name cannot be empty')
    end

    it 'stops registration and shows seperate message if last name field not filled in' do
      post '/registermentor', 'firstname' => 'mentor1Fname', 'email' => 'mentor1@email.com', 'username' => 'mentor1',
                              'password' => 'mentor1', 'domain' => 'COMP'
      expect(last_response.body).to include('Last Name cannot be empty')
    end

    it 'stops registration and shows seperate message if email field not filled in' do
      post '/registermentor', 'firstname' => 'mentor1Fname', 'lastname' => 'mentor1Lname',
                              'username' => 'mentor1', 'password' => 'mentor1', 'domain' => 'COMP'
      expect(last_response.body).to include('Email cannot be empty')
    end

    it 'stops registration and shows seperate message if username field not filled in' do
      post '/registermentor', 'firstname' => 'mentor1Fname', 'lastname' => 'mentor1Lname',
                              'email' => 'mentor1@test.com', 'password' => 'mentor1', 'domain' => 'COMP'
      expect(last_response.body).to include('Username cannot be empty')
    end

    it 'stops registration and shows seperate message if password field not filled in' do
      post '/registermentor', 'firstname' => 'mentor1Fname', 'lastname' => 'mentor1Lname',
                              'email' => 'mentor1@email.com', 'username' => 'mentor1', 'domain' => 'COMP'
      expect(last_response.body).to include('Password cannot be empty')
    end

    it 'stops registration and shows seperate message if domain field not filled in' do
      post '/registermentor', 'firstname' => 'mentor1Fname', 'lastname' => 'mentor1Lname',
                              'email' => 'mentor1@email.com', 'username' => 'mentor1', 'password' => 'mentor1'
      expect(last_response.body).to include('Domain cannot be empty')
    end
    
    it 'stops registration and shows seperate message username is already taken' do
      register_mentor
      post '/registermentor', 'firstname' => 'mentor1Fname', 'lastname' => 'mentor1Lname',
                              'email' => 'mentor100@email.com', 'username' => 'mentor1', 'password' => 'mentor1',
                              'domain' => 'COMP'
      expect(last_response.body).to include('Username is already taken')
      clear_database_mentor
    end
    
    it 'stops registration and shows seperate message email is already taken' do
      register_mentor
      post '/registermentor', 'firstname' => 'mentor1Fname', 'lastname' => 'mentor1Lname',
                              'email' => 'mentor1@test.com', 'username' => 'mentor100', 'password' => 'mentor1',
                              'domain' => 'COMP'
      expect(last_response.body).to include('Email is already taken.')
      clear_database_mentor
    end
  end
end
