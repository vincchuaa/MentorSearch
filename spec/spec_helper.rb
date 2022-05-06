# frozen_string_literal: true

# Ensure we use the test database
ENV['APP_ENV'] = 'test'

# Log test coverage with simplecov
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end
SimpleCov.coverage_dir 'coverage'

# load the app
require_relative '../app'

# Configure Capybara
require 'capybara/rspec'
Capybara.app = Sinatra::Application

# Configure RSpec
def app
  Sinatra::Application
end
RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end
#----------------------Start of mentee methods----------------#


def choose_mentee
  visit '/choose'
  click_link href: 'register'
end

def suspend_mentee
  DB.execute("INSERT INTO mentees(email, username, password, suspended) VALUES ('mentee3@sheffield.ac.uk', 'suspended_mentee', 'susMent', 1)")
end

def register_user
  visit '/register'
  fill_in 'email', with: 'mentee1@sheffield.ac.uk'
  fill_in 'username', with: 'mentee1'
  fill_in 'password', with: 'mentee1'
  click_button 'submit'
end

#this user is used for searching purposes
def register_user2
  visit '/register'
  fill_in 'email', with: 'mentee9@sheffield.ac.uk'
  fill_in 'username', with: 'mentee9'
  fill_in 'password', with: 'mentee9'
  click_button 'submit'
end

def register_user_missing
  visit '/register'
  fill_in 'username', with: 'mentee1'
  fill_in 'password', with: 'mentee1'
  click_button 'submit'
end

def choose_mentee_login
  visit '/chooselogin'
  click_link href: 'login'
end

def login_user
  visit '/login'
  fill_in 'username', with: 'mentee1'
  fill_in 'password', with: 'mentee1'
  click_button 'submit'
end

def login_user2
  visit '/login'
  fill_in 'username', with: 'mentee9'
  fill_in 'password', with: 'mentee9'
  click_button 'submit'
end

# forces an invalid mentee for session validation
def get_invalid_mentee_session
  get '/editmentee', {}, 'rack.session' => { :user_type => 'Mentee', :user_id => '444' }
end

def post_invalid_mentee_session
  post '/editmentee', {}, 'rack.session' => { :user_type => 'Mentee', :user_id => '444' }
end

def get_invalid_mentor_session
  get '/editmentor', {}, 'rack.session' => { :user_type => 'Mentor', :user_id => '444' }
end

def post_invalid_mentor_session
  post '/editmentor', {}, 'rack.session' => { :user_type => 'Mentor', :user_id => '444' }
end

def login_user_missing
  visit '/login'
  fill_in 'password', with: 'mentee1'
  click_button 'submit'
end

def login_as_suspended_mentee
  visit '/login'
  fill_in 'username', with: 'suspended_mentee'
  fill_in 'password', with: 'susMent'
  click_button 'submit'
end

#login with changed password
def changedpass_login_user2
  visit '/login'
  fill_in 'username', with: 'mentee9'
  fill_in 'password', with: 'changedpass'
  click_button 'submit'
end

def email_mentor
  visit '/search'
  click_button 'Send an email'
end

def request_mentor
  visit '/request/1'
  visit '/profile'
end

#might get rid of this method as its very simple
def accepted_request
  visit '/profile'
end

def change_password_user2
  click_link href: '/profile'
  click_link href: '/editmentee?id=2'
  fill_in 'password' , with: 'changedpass'
  click_button 'submit'
end

def logout_user
  visit '/search'
  click_link href: 'logout'
end

#------------------------------start of mentor methods---------------------#
def choose_mentor
  visit '/choose'
  click_link href: 'registermentor'
end
def suspend_mentor
  DB.execute("INSERT INTO mentors(email, username, password, firstname, lastname, domain, suspended) VALUES ('mentor4@sheffield.ac.uk', 'suspended_mentor', 'susMent', 'susFirst', 'susLast', 'SUSP', 1)")
end

def register_mentor
  visit '/registermentor'
  fill_in 'firstname', with: 'mentor1Fname'
  fill_in 'lastname', with: 'mentor1Lname'
  fill_in 'email', with: 'mentor1@test.com'
  fill_in 'username', with: 'mentor1'
  fill_in 'password', with: 'mentor1'
  fill_in 'domain', with: 'COMP'
  click_button 'submit'
end

#This user is used for searching purposes
def register_mentor2
  visit '/registermentor'
  fill_in 'firstname', with: 'mentor1Fname'
  fill_in 'lastname', with: 'mentor1Lname'
  fill_in 'email', with: 'mentor9@test.com'
  fill_in 'username', with: 'mentor9'
  fill_in 'password', with: 'mentor9'
  fill_in 'domain', with: 'ENG'
  click_button 'submit'
end

def register_mentor_missing
  visit '/registermentor'
  fill_in 'firstname', with: 'mentor1Fname'
  fill_in 'lastname', with: 'mentor1Lname'
  fill_in 'username', with: 'mentor1'
  fill_in 'password', with: 'mentor1'
  click_button 'submit'
end

def choose_mentor_login
  visit '/chooselogin'
  click_link href: 'loginmentor'
end

def login_mentor
  visit '/loginmentor'
  fill_in 'username', with: 'mentor1'
  fill_in 'password', with: 'mentor1'
  click_button 'submit'
end

def login_mentor2
  visit '/loginmentor'
  fill_in 'username', with: 'mentor9'
  fill_in 'password', with: 'mentor9'
  click_button 'submit'
end

def loginmentor_user_missing
  visit '/loginmentor'
  fill_in 'password', with: 'mentor1'
  click_button 'submit'
end

def login_as_suspended_mentor
  visit '/loginmentor'
  fill_in 'username', with: 'suspended_mentor'
  fill_in 'password', with: 'susMent'
  click_button 'submit'
end

def change_password_mentor2
  click_link href: '/editmentor?id=2'
  fill_in 'password' , with: 'changedpass'
  click_button 'submit'
end

#login with changed password
def changedpass_login_mentor2
  visit '/loginmentor'
  fill_in 'username', with: 'mentor9'
  fill_in 'password', with: 'changedpass'
  click_button 'submit'
end

def logout_mentor
  click_link href: 'logout_mentor'
end

def accept_mentee
  visit '/accept_mentee?id=1'
end

def search_for_mentor
  visit '/search'
  fill_in 'search_field', with: 'COM'
  click_button 'submit'
end

def search_for_mentor_missing
  visit '/search'
  fill_in 'search_field', with: 'Jibberish'
  click_button 'submit'
end

def search_for_mentor_empty
  visit 'search'
  click_button 'submit'
end

#------------------------start of admin methods--------------------
def login_admin
  visit '/loginadmin'
  fill_in 'username', with: 'admin'
  fill_in 'password', with: 'admin'
  click_button 'submit'
end

def admin_search_mentee
  visit '/adminsearch'
  fill_in 'email_search', with: 'mentee1'
  click_button 'submit'
end

def admin_search_mentor
  visit '/adminsearch'
  fill_in 'email_search_mentor', with: 'mentor1'
  click_button 'submit_mentor'
end

def admin_edit_password
  click_link href: '/adminedit?id=2'
  fill_in 'password', with: 'changedpass'
  click_button 'submit'
end

def admin_edit_password_mentor
  click_link href: '/adminedit_mentor?id=2'
  fill_in 'password', with: 'changedpass'
  click_button 'submit'
end

def admin_suspend
  click_link href: '/adminedit?id=2'
  click_button 'suspend'
end

def admin_suspend_mentor
  click_link href: '/adminedit_mentor?id=2'
  click_button 'suspend'
end

def admin_restore
  click_link href: '/adminedit?id=2'
  click_button 'restore'
end

def admin_restore_mentor
  click_link href: '/adminedit_mentor?id=2'
  click_button 'restore'
end

def admin_logout
  click_link href: 'logout_admin'
end

def admin_add_suffix
  fill_in 'suffix', with: 'a.test'
  click_button 'submit'
end

#------------clearing tables methods--------------
def clear_database
  DB.from('mentees').delete
end

def clear_database_mentor
  DB.from('mentors').delete
end

def clear_database_request
  DB.from('requests').delete
end
