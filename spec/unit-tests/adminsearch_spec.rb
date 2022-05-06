require_relative '../spec_helper'

RSpec.describe 'admin search feature: ' do
  describe 'search for a user' do
    it 'admin searches for a mentee by entering their email' do
      #clear databases
      clear_database
      clear_database_mentor
      register_user
      register_user2
      login_admin
      admin_search_mentee
      #initially page displays value for mentee1 and mentee9, after search only mentee1 shows
      expect(page).not_to have_content('mentee9')
      expect(page).to have_content('mentee1')
    end
    
    it 'admin searches for a mentor using their email' do
      register_mentor
      register_mentor2
      login_admin
      admin_search_mentor
      #initially page displays value for mentor1 and mentor9, after search only mentor1 shows
      expect(page).not_to have_content('mentor9')
      expect(page).to have_content('mentor1')
    end
    # implement this validation
    it 'admin searches for a user mentee that doesnt exist' do
      login_admin
      fill_in 'email_search', with: 'doesntExist'
      click_button 'submit'
      expect(page).to have_content('No mentees match your search')
    end
    
    it 'admin searches for a mentor that doesnt exist' do
      login_admin
      fill_in 'email_search_mentor', with: 'doesntExist'
      click_button 'submit_mentor'
      expect(page).to have_content('No mentors match your search')
    end
    
    it 'admin logs out and is returned to the admin login screen' do
      login_admin
      visit '/logout_admin'
      expect(page).to have_content('Admin Login')
    end
    
    it 'visit adminsearch page while not logged in as admin, and is returned to the adminlogin screen' do 
      login_user
      visit '/adminsearch'
      expect(page).to have_content('Admin Login')
    end
  end
end
      