require_relative '../spec_helper'

RSpec.describe 'admin login, search, edit password, suspend and restore features: ' do
  describe 'login as an admin' do
    it 'admin is successfully logged in and is taken to admin search page' do
      #clearing the database mentee + mentor tables
      clear_database
      clear_database_mentor
      login_admin
      expect(page).to have_content('User search')
    end
  end
  
  describe 'admin visits their profile' do
    it 'admin can view their profile when logged in' do
      login_admin
      visit '/profile'
      expect(page).to have_content('Account Details')
    end
  end
  
  describe 'admin searches for a user using their email' do
    it 'admin searches for a mentee' do 
      register_user
      register_user2
      login_admin
      admin_search_mentee
      #initially page displays value for mentee1 and mentee9, after search only mentee1 shows
      expect(page).not_to have_content('mentee9')
      expect(page).to have_content('mentee1')
    end
    
    it 'admin searches for a mentor' do 
      register_mentor
      register_mentor2
      login_admin
      admin_search_mentor
      #initially page displays value for mentor1 and mentor9, after search only mentor1 shows
      expect(page).not_to have_content('mentor9')
      expect(page).to have_content('mentor1')
    end
  end
  
  describe 'admin edits a users password' do
    it 'admin successfully changes a mentees password and mentee can log in with new password' do
      login_admin
      admin_edit_password
      changedpass_login_user2
      expect(page).to have_content('Search')  
    end
    
     it 'admin successfully changes a mentors password and mentor can log in with new password' do
      login_admin
      admin_edit_password_mentor
      changedpass_login_mentor2
      expect(page).to have_content('Personal Details')  
    end
  end
  
  describe 'admin suspends a user' do
    it 'admin suspends a mentee, mentee is unable to login and is taken to suspended page' do
      login_admin
      admin_suspend
      changedpass_login_user2
      expect(page).to have_content('Your account is suspended')
    end
    
    it 'admin suspends a mentor, mentor is unable to login and is taken to suspended page' do
      login_admin
      admin_suspend_mentor
      changedpass_login_mentor2
      expect(page).to have_content('Your account is suspended')
    end
  end
  
  describe 'admin restores suspended user' do
    it 'admin restores suspended mentee, mentee able to login successfully' do
      login_admin
      admin_restore
      changedpass_login_user2
      expect(page).to have_content('Search')
    end
    
    it 'admin restores suspended mentor, mentore is able to login successfully' do
      login_admin
      admin_restore_mentor
      changedpass_login_mentor2
      expect(page).to have_content('Personal Details')
    end
  end
  
  describe 'admin is able to logout' do
    it 'admin logs out of account and is redirected to admin login page' do
      login_admin
      admin_logout
      expect(page).to have_content('Admin Login')
      #clearing databases
      clear_database
      clear_database_mentor
    end
  end
  
end
    