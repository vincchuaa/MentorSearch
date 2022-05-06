# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Testing views' do
  def app
    Sinatra::Application
  end
  
  describe '/adminedit response' do
    it 'returns status code of 200 (OK) for adminedit page' do
      login_admin
      visit '/adminedit'
      expect(page.status_code).to eq(200)
    end
    it "contains 'Edit mentee'" do
      register_user
      login_admin
      visit '/adminedit?id=1'
      expect(page).to have_content("Edit mentee")
    end
  end
  
  describe '/adminedit_mentor response' do
    it 'returns status code of 200 (OK) for adminedit_mentor page' do
      login_admin
      visit '/adminedit_mentor'
      expect(page.status_code).to eq(200)
    end
    it "contains 'Edit mentor'" do
      register_mentor
      login_admin
      visit '/adminedit_mentor?id=1'
      expect(page).to have_content("Edit mentor")
    end
  end
  
  describe '/adminsearch response' do
    it 'returns status code of 200 (OK) for adminsearch page' do
      login_admin
      expect(page.status_code).to eq(200)
    end
    it "contains 'User search'" do
      login_admin
      expect(page).to have_content("User search")
    end
  end
  
  describe 'GET /choose' do
    it 'has a status code of 200 (OK) for register choice page' do
      get '/choose'
      expect(last_response).to be_ok
    end
    it "contains 'Are you a' so user can choose how to register" do
      get '/choose'
      expect(last_response.body).to include('Are you a')
    end
  end
  
  describe 'GET /chooselogin' do
    it 'has a status code of 200 (OK) for login choice page' do
      get '/chooselogin'
      expect(last_response).to be_ok
    end
    it "contains 'Are you a' so user can choose how to login" do
      get '/chooselogin'
      expect(last_response.body).to include('Are you a')
    end
  end

#Moving to the editmentee page when not logged in currently crashes
#As there is no check, so if the user is not logged in [:username] creates an error

  describe '/editmentee response' do
    it 'returns status code of 200 (OK) for editmentee page' do
      login_user
      visit '/editmentee'
      expect(page.status_code).to eq(200)
    end
    it "contains 'Account Details'" do
      login_user
      visit '/editmentee'
      expect(page).to have_content("Account Details")
    end
  end

    
  describe 'GET /error500' do
    it 'has a status code of 200 (OK) for error500 page' do
      get '/error500'
      expect(last_response).to be_ok
    end
    it 'contains correct error message' do
      get '/error500'
      expect(last_response.body).to include('The server encountered an internal error and is unable to complete your request')
    end
  end
  
  describe 'GET /' do
    it 'has a status code of 200 (OK) for landing page' do
      get '/'
      expect(last_response).to be_ok
    end
    it 'introduces the website to the user' do
      get '/'
      expect(last_response.body).to include('Get advice and mentorship from industry experts')
    end
  end
    
  describe 'GET /login' do
    it 'has a status code of 200 (OK) for login page' do
      get '/login'
      expect(last_response).to be_ok
    end
    it "contains 'Login to MentorSearch'" do
      get '/login'
      expect(last_response.body).to include('Login to MentorSearch')
    end
  end 
  
  describe 'GET /loginadmin' do
    it 'has a status code of 200 (OK) for loginadmin page' do
      get '/loginadmin'
      expect(last_response).to be_ok
    end
    it "contains 'Admin Login'" do
      get '/loginadmin'
      expect(last_response.body).to include('Admin Login')
    end
  end
  
  describe 'GET /loginmentor' do
    it 'has a status code of 200 (OK) for loginmentor page' do
      get '/loginmentor'
      expect(last_response).to be_ok
    end
    it "contains 'Login to MentorSearch'" do
      get '/loginmentor'
      expect(last_response.body).to include('Login to MentorSearch')
    end
  end
  
  describe 'GET /not_found' do
    it 'has a status code of 200 (OK) for error404 page' do
      get '/not_found'
      expect(last_response).to be_ok
    end
    it 'contains correct error message' do
      get '/not_found'
      expect(last_response.body).to include('The page you were looking for does not exist!')
    end
  end

#Multi line comments broken sad 
#Dont currently know how this page is used/accessed
  describe '/profile responses' do
    it 'has a status code of 200 (OK) for profile page' do
      login_user
      visit '/profile'
      expect(page.status_code).to eq(200)
    end
    it 'contains correct details' do
      login_user
      visit '/profile'
      expect(page).to have_content('Pairing Request')
   end
 end
  
  describe 'GET /register' do
    it 'has a status code of 200 (OK) for register page' do
      get '/register'
      expect(last_response).to be_ok
    end
    it "contains 'Registration Page Mentee'" do
      get '/register'
      expect(last_response.body).to include('Registration Page Mentee')
    end
  end

  describe 'GET /registermentor' do
    it 'has a status code of 200 (OK) for register page' do
      get '/registermentor'
      expect(last_response).to be_ok
    end
    it "contains 'Registration Page Mentor'" do
      get '/registermentor'
      expect(last_response.body).to include('Registration Page Mentor')
    end
  end
  
  describe 'GET /search' do
    it 'returns status code of 200 (OK) for search page' do
      get '/search'
      expect(last_response).to be_ok
    end
    it "contains 'Search'" do
      get '/search'
      expect(last_response.body).to include('Search')
    end
  end

  describe 'GET /suspend' do
    it 'returns status code of 200 (OK) for suspend page' do
      get '/suspend'
      expect(last_response).to be_ok
    end
    it "contains 'Your account is suspended'" do
      get '/suspend'
      expect(last_response.body).to include('Your account is suspended')
    end
  end
  
  describe 'GET /forgotpassword' do
    it 'returns status code of 200 (OK) for forgot my password page' do
      get '/forgotpassword'
      expect(last_response).to be_ok
    end
    it "contains 'Forgot My Password'" do
      get '/forgotpassword'
      expect(last_response.body).to include('Forgot My Password')
    end
  end

  describe 'checking email status' do
    it 'HTTP:Success true ' do
      expect(send_email('recipient' => 'mentor@sheffield.ac.uk', 'subject' => 'Test email',
      'body' => "Testing valid email.", 'sender' => 'mentee@sheffield.ac.uk')).to eq(true)
    end
    
    it 'HTTP:Success false for invalid email' do
      expect(send_email('recipient' => 'mentor@sheffield.ac.uk', 'subject' => 'Test email',
      'body' => "Testing valid email.", 'sender' => 'sheffield.ac.uk')).to eq(false)
    end
  end
end
