# frozen_string_literal: true

require_relative '../spec_helper'


RSpec.describe 'mentor registration, login' do
  describe 'click the button to register as mentor' do
    it 'user is taken to the registration page for mentors' do
      #clearing databases
      clear_database
      clear_database_mentor
      clear_database_request
      choose_mentor
      expect(page).to have_content('Registration Page Mentor')
    end
  end

  describe 'user tries to register as mentee' do
    it 'user forgets to fill in all the fields and error is displayed' do
      register_mentor_missing
      expect(page).to have_content('Please correct the information below')
    end

    it 'user is redirected to login page after successful registration' do
      register_mentor
      expect(page).to have_content('Login to MentorSearch')
    end
  end

  describe 'user tries to login as mentor' do
    it 'user forgets to fill in all the fields and error is displayed' do
      loginmentor_user_missing
      expect(page).to have_content('Username or password are incorrect')
    end

    it 'user enters correct username and password and is taken to the profile page' do
      login_mentor
      expect(page).to have_content('Personal Details')
    end
  end
  
  describe 'user changes their password' do
    it 'mentor changes their password and logs in with changed password' do
      register_mentor2
      login_mentor2
      change_password_mentor2
      changedpass_login_mentor2
      expect(page).to have_content('You are currently logged in as mentor9')
    end
  end
  
  describe 'user accepts pair request from mentee' do
    it 'accepts pair request and is shown a confirmation on the screen' do
      register_user
      login_user
      request_mentor
      login_mentor
      accept_mentee
      expect(page).to have_content('You have accepted this mentee')
    end
  end
  
  describe 'user is able to logout' do
    it 'mentor is able to logout of their account' do
      login_mentor
      logout_mentor
    end
  end
end
