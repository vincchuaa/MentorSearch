# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Testing redirection to error pages' do
  def app
    Sinatra::Application
  end

  describe 'GET /doesNotExist' do
    it 'has a status code of 200 (OK) for error404 page' do
      get '/not_found'
      expect(last_response).to be_ok
    end

    it 'redirects to the error page for a page that does not exist' do
      get '/doesNotExist'
      expect(last_response.body).to include('The page you were looking for does not exist!')
    end
  end
end
