# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'admins can edit the whitelisted email list' do
  describe 'functionality of the whitelist' do
    it 'admins can view the whitelist' do
      login_admin
      visit '/admin_whitelist'
      expect(page).to have_content('Add an email suffix to the whitelist:')
    end
    
    it 'admins can add to the whitelist' do
      login_admin
      visit '/admin_whitelist'
      admin_add_suffix
      expect(page).to have_content('a.test')
    end
    
    it 'admins can delete from the whitelist' do
      login_admin
      visit '/admin_whitelist'
      visit '/admin_whitelist_remove?suffix=a.test'
      expect(page).to_not have_content('a.test')
    end
    
    it 'visit whitelist page while not logged in as admin, and is returned to the adminlogin screen' do 
      login_user
      visit '/admin_whitelist'
      expect(page).to have_content('Admin Login')
    end
  end
end