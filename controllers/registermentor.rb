# frozen_string_literal: true

# creating a new mentor account
get '/registermentor' do
  # page initially uses blank user with no errors
  @user = Mentor.new
  erb :registermentor
end

post '/registermentor' do
  # creates a new Mentee object with the params to validate
  @user = Mentor.new
  @user.load(params)
  # holds an error message if any corrections need to be made
  @error = nil

  # ensures all fields are filled and valid
  if @user.valid?
    unless @user.taken?
      # if no errors, saves user to the database and redirects to the login page
      @user.save_changes
      redirect '/loginmentor'
    end
  else
    @error = 'Please correct the information below'
  end

  # if any errors, returns register page with errors displayed
  erb :registermentor
end
