# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'the search page' do
  describe 'search for a mentor' do
    # this only checks guest functionality. logged in search is tested in mentee_spec.rb
    it 'page contains the number of matches searched for' do
      register_mentor
      search_for_mentor
      expect(page).to have_content('There is 1 mentor that can help you, only available ones are shown')
      clear_database_mentor
    end

    it 'page says no mentors found if a mentor doesnt exist' do
      search_for_mentor_missing
      expect(page).to have_content('No mentors match your search')
    end
    
    it 'searches when no mentors exist' do
      clear_database_mentor
      search_for_mentor
      expect(page).to have_content('No mentors match your search')
      clear_database_mentor
    end
  end
end
