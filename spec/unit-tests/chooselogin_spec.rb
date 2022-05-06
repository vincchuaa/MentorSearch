# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'checking buttons on chooselogin page' do
  describe 'click the button to login as mentee' do
    it 'when button clicked it takes you to register as mentee page' do
      choose_mentee_login
      expect(page).to have_content('Login to MentorSearch')
    end
  end

  describe 'click the button to login as mentor' do
    it 'when button clicked it takes you to register as mentor page' do
      choose_mentor_login
      expect(page).to have_content('Login to MentorSearch')
    end
  end
end
