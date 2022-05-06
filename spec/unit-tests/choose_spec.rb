# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'checking buttons on choose page' do
  describe 'click the button to register as mentee' do
    it 'when button clicked it takes you to register as mentee page' do
      choose_mentee
      expect(page).to have_content('Registration Page Mentee')
    end
  end

  describe 'click the button to register as mentor' do
    it 'when button clicked it takes you to register as mentor page' do
      choose_mentor
      expect(page).to have_content('Registration Page Mentor')
    end
  end
end
