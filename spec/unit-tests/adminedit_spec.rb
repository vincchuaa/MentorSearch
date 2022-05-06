RSpec.describe 'admin edit user features: ' do
  describe 'admin changes users password' do
    it 'admin edits a mentees password and mentee can successfully login with that password' do
      #clearing databases
      clear_database
      clear_database_mentor
      register_user
      register_user2
      login_admin
      admin_edit_password
      changedpass_login_user2
      expect(page).to have_content('Search')
    end
    
    it 'admin edits a mentors password and mentor can successfully login with that password' do
      clear_database_mentor
      register_mentor
      register_mentor2
      login_admin
      admin_edit_password_mentor
      changedpass_login_mentor2
      expect(page).to have_content('Personal Details')
    end
  end
  
  describe 'admin tries to submit empty password field' do
    it ' an error message is shown for the empty password field for mentees' do
      login_admin
      visit '/adminedit?id=1'
      fill_in 'password', with: ''
      click_button 'submit'
      expect(page).to have_content('Password cannot be empty')
    end
    
    it ' an error message is shown for the empty password field for mentors' do
      login_admin
      visit '/adminedit_mentor?id=1'
      fill_in 'password', with: ''
      click_button 'submit'
      expect(page).to have_content('Password cannot be empty')
    end
  end
  
  describe 'non admin user attempts to access admin pages' do
    it 'when not logged in as admin, the adminedit page cannot be accessed' do
      login_user
      visit '/adminedit'
      expect(page).to have_content('Admin Login')
    end
    
    it 'when not logged in as admin, the adminedit_mentor page cannot be accessed' do
      login_user
      visit '/adminedit_mentor'
      expect(page).to have_content('Admin Login')
    end
  end
end