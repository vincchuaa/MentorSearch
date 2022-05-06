require_relative '../spec_helper'

RSpec.describe 'admin suspend and restore features: ' do
  describe 'admin suspends a user' do
    it 'admin suspends a mentee' do
      #clearing databases
      clear_database
      clear_database_mentor
      register_user
      register_user2
      login_admin
      admin_suspend
      login_user2
      expect(page).to have_content('Your account is suspended')
    end
    
    it 'admin suspends a mentor' do
      register_mentor
      register_mentor2
      login_admin
      admin_suspend_mentor
      login_mentor2
      expect(page).to have_content('Your account is suspended')
    end
  end
  
  describe 'admin restores a suspended user'do
    it 'admin restores the suspended mentee' do
      login_admin
      admin_restore
      login_user2
      expect(page).to have_content('Search')
    end
    
    it 'admin restores the suspended mentor' do
      login_admin
      admin_restore_mentor
      login_mentor2
      expect(page).to have_content('Personal Details')
    end
  end
end