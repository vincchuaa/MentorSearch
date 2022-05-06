# frozen_string_literal: true

# controls logging in as a mentee
get '/login' do
  @user = Mentee.new
  erb :login
end

post '/login' do
  # creates a temporary Mentee with posted credentials for validation
  @user = Mentee.new
  @user.load(params)
  @user.validate

  session.clear

  # checks credentials match a record in the database
  if @user.exist?
    # retrieves the user's database record
    @user_record = Mentee.first(username: @user.username)
    # only logs in if user not suspended
    if @user_record.suspended.zero?
      session[:logged_in] = true
      session[:username] = @user_record.username
      session[:email] = @user_record.email
      session[:user_id] = @user_record.id
      session[:user_type] = 'Mentee'
      redirect '/search'
    else
      redirect '/suspend'
    end
  else
    @error = 'Username or password are incorrect.'
  end

  # credentials do not match a record: return login page with errors
  erb :login
end
