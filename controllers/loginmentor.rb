# frozen_string_literal: true

# controls logging in as a mentor
get '/loginmentor' do
  @user = Mentor.new
  erb :loginmentor
end

post '/loginmentor' do
  # creates a temporary Mentor with posted credentials for validation
  @user = Mentor.new
  @user.load(params)
  @user.validate

  session.clear

  # checks credentials match a record in the database
  if @user.exist?
    # retrieves the user's database record
    @user_record = Mentor.first(username: @user.username)
    # only logs in if user not suspended
    if @user_record.suspended.zero?
      session[:logged_in] = true
      session[:username] = @user_record.username
      session[:user_id] = @user_record.id
      session[:user_type] = 'Mentor'
      redirect '/profile'
    else
      redirect '/suspend'
    end
  else
    @error = 'Username or password are incorrect.'
  end

  # credentials do not match a record: return login page with errors
  erb :loginmentor
end
