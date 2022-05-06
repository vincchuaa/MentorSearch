# frozen_string_literal: true

require_relative '../spec_helper'


RSpec.describe 'mentee registration, login and search' do
  describe 'click the button to register as mentee' do
    #clearing databases
    clear_database_request
    clear_database_mentor
    clear_database
    it 'user is taken to the registration page for mentees' do
      choose_mentee
      expect(page).to have_content('Registration Page Mentee')
    end
  end

  describe 'user tries to register as mentee' do
    it 'user forgets to fill in all the fields and error is displayed' do
      register_user_missing
      expect(page).to have_content('Please correct the information below')
    end
    
    it 'user registered successfully and is taken to login page' do
      register_user
      expect(page).to have_content('Login to MentorSearch')
    end
  end

  describe 'user tries to login as mentee' do
    it 'user forgets to fill in all the fields and error is displayed' do
      login_user_missing
      expect(page).to have_content('Username or password are incorrect')
    end
    
    it 'user enters correct username and password and is taken to the search page, with logged in specific content' do
      login_user
      expect(page).to have_content('You are currently logged in as mentee1')
    end
  end

  describe 'user searches for a mentor' do
    it 'user searches for a mentor by domain and is given list of mentors' do
      #have to register mentor again, as mentors database cleared at end of mentor spec
      register_mentor
      login_user
      search_for_mentor
      expect(page).to have_content('COM')
    end

    it 'user searches for a non existing mentor' do
      search_for_mentor_missing
      expect(page).to have_content('No mentors match your search')
    end
  end
  
  describe 'user emails a mentor' do
    it 'mentee sends an email to mentor1 without crash (status of send_email in separate test)' do
      login_user
      email_mentor
      expect(page).to have_content('Search') 
    end
  end
  
  describe 'user requests to pair with a mentor' do
    it 'mentee sends a request to mentor1' do
      login_user
      request_mentor
      expect(page).to have_content('mentor1') 
    end
  end
  
  describe 'user is paired with a mentee' do
    it 'mentor1 accepts mentee1s request to pair' do
      login_mentor
      accept_mentee
      login_user
      accepted_request
      expect(page).to have_content('This mentee has accepted your request to pair')
    end
  end
      
  describe 'user edits profile' do
    it 'mentee changes password' do
      register_user2
      login_user2
      change_password_user2
      changedpass_login_user2
      expect(page).to have_content('You are currently logged in as mentee9')
    end
  end
  
  describe 'user logs out' do
    it 'returns user to guest view of login page' do
      login_user
      logout_user
      expect(page).to have_content('Sign up here')
    end
  end
end
