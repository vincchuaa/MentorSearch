# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'the request functionality' do
  describe 'accepting requests' do
    it 'mentors can accept incoming requests from mentees' do
      clear_database_request
      login_user
      request_mentor
      login_mentor
      accept_mentee
      expect(page).to have_content('You have accepted this mentee')
    end
  end
  
  describe 'cancelling requests' do
    it 'mentees can cancel outgoing requests' do
      clear_database_request
      clear_database
      clear_database_mentor
      register_user
      register_mentor
      login_user
      request_mentor
      visit '/profile'
      expect(page).to have_content('You have the following request pending:')
      visit '/cancel_request?id=1'
      expect(page).to have_content('You have no pending mentor requests.')
    end
  end
end