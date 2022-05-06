# frozen_string_literal: true

# controls logging in as an admin
get '/loginadmin' do
  @user = Admin.new
  erb :loginadmin
end

post '/loginadmin' do
  # creates a temporary Admin with posted credentials for validation
  @user = Admin.new
  @user.load(params)
  @user.validate

  session.clear

  # checks credentials match a record in the database
  if @user.exist?
    # retrieves the admin's database record
    @user_record = Admin.first(username: @user.username)
    session[:logged_in] = true
    session[:username] = @user_record.username
    session[:user_id] = @user_record.id
    session[:user_type] = 'Admin'
    redirect '/adminsearch'
  else
    @error = 'Username or password are incorrect.'
  end

  # credentials do not match a user record: return login page with errors
  erb :loginadmin
end
