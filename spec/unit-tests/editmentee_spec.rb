require_relative '../spec_helper'


RSpec.describe 'mentee edit details' do
  describe 'session: nonexistent mentee attempts to edit' do
    it 'tries to get nonexistent mentee, redirects to landing page' do
      get_invalid_mentee_session
      visit '/editmentee'
      expect(page).to have_content('Get advice')
    end  
    
    it 'tries to post nonexistent mentee, redirects to landing page' do
      visit '/editmentee'
      post_invalid_mentee_session
      expect(page).to have_content('Get advice')
    end 
  end  
  
  describe 'mentee edits their profile details' do
    it 'successfully changes their email and sees their new email on profile page' do
      #clearing database
      clear_database_request
      clear_database_mentor
      clear_database
      register_user
      login_user
      visit '/editmentee?id=1'
      fill_in 'email' , with: 'new@sheffield.ac.uk'
      click_button 'submit'
      expect(page).to have_content('Email: new@sheffield.ac.uk')
    end
    
    it'successfully changes their username and sees their new username on profile page' do
      login_user
      visit '/editmentee?id=1'
      fill_in 'username' , with: 'newUsername' 
      click_button 'submit'
      expect(page).to have_content('Username: newUsername')
    end
    
    it 'successfully changes their password and is able to login with new password' do
      clear_database
      register_user
      login_user
      visit '/editmentee?id=1'
      fill_in 'password' , with: 'newPassword' 
      click_button 'submit'
      visit '/login'
      fill_in 'username' , with: 'mentee1'
      fill_in 'password' , with: 'newPassword'
      click_button 'submit'
      expect(page).to have_content('You are currently logged in as mentee1')
    end
     
    it 'tries to submit with empty password field' do
      clear_database
      register_user
      login_user
      visit '/editmentee?id=1'
      fill_in 'email' , with: ''
      click_button 'submit'
      expect(page).to have_content('Email cannot be empty')
    end
    
    it 'tries to submit with empty email field' do
      clear_database
      register_user
      login_user
      visit '/editmentee?id=1'
      fill_in 'email' , with: ''
      click_button 'submit'
      expect(page).to have_content('Email cannot be empty')
    end
    
    it 'tries to submit with empty username field' do
      login_user
      visit '/editmentee?id=1'
      fill_in 'username' , with: ''
      click_button 'submit'
      expect(page).to have_content('Username cannot be empty')
    end
    
    it 'tries to submit with empty password field' do
      login_user
      visit '/editmentee?id=1'
      fill_in 'password' , with: ''
      click_button 'submit'
      expect(page).to have_content('Password cannot be empty')
    end
    
    it 'tries to change their email to an email thats already taken' do
      register_user2
      login_user
      visit '/editmentee?id=1'
      fill_in 'email' , with: 'mentee9@sheffield.ac.uk'
      click_button 'submit'
      expect(page).to have_content('Email is already taken')
    end
    
    it 'tries to change their username to a username thats already taken' do
      login_user
      visit '/editmentee?id=1'
      fill_in 'username' , with: 'mentee9'
      click_button 'submit'
      expect(page).to have_content('Username is already taken')
    end 
    
    it 'visits the editmentee page without being logged in, which causes a return to the landing page' do
      visit '/editmentee'
      expect(page).to have_content('Get advice and mentorship from industry experts')
    end
    
  end
end
      