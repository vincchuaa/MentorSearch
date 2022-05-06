# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'mentor edit details' do
  describe 'session: nonexistent mentor attempts to edit' do
    it 'tries to get nonexistent mentor, redirects to landing page' do
      get_invalid_mentor_session
      visit '/editmentor'
      expect(page).to have_content('Get advice')
    end  
    
    it 'tries to post nonexistent mentor, redirects to landing page' do
      visit '/editmentor'
      post_invalid_mentor_session
      expect(page).to have_content('Get advice')
    end 
  end  
  
  describe 'mentor edits their profile details' do
    it 'mentor changes their email to one that is taken' do
      clear_database_mentor
      register_mentor
      register_mentor2
      login_mentor
      expect(page).to have_content('Personal Details')
      visit '/editmentor?id=1'
      fill_in 'email', with: 'mentor9@test.com'
      click_button 'Save Changes'
      expect(page).to have_content('Email is already taken.')
    end
    
    it 'mentor changes their username to one that is taken' do
      clear_database_mentor
      register_mentor
      register_mentor2
      login_mentor
      expect(page).to have_content('Personal Details')
      visit '/editmentor?id=1'
      fill_in 'username', with: 'mentor9'
      click_button 'Save Changes'
      expect(page).to have_content('Username is already taken.')
    end
    
    it 'mentor changes their avaliability' do
      clear_database_mentor
      register_mentor
      login_mentor
      expect(page).to have_content('Personal Details')
      expect(page).to have_content('You are currently available')
      choose('availability', option: 'unavailable')
      click_button 'submit'
      expect(page).to have_content('You are currently unavailable')
      choose('availability', option: 'available')
      click_button 'submit'
      expect(page).to have_content('You are currently available')
    end
    
  end
end