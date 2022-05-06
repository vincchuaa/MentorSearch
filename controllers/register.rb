# frozen_string_literal: true

# creating a new mentee account
get '/register' do
  # page initially uses blank user with no errors
  @user = Mentee.new
  erb :register
end

# registers with parameters
post '/register' do
  # creates a new Mentee object with the params to validate
  @user = Mentee.new
  @user.load(params)
  # holds an error message if any corrections need to be made
  @error = nil

  # reads whitelisted university addresses from the whitelist file
  suffix_list = []
  if File.exist?('db/suffix_list.txt')
    suffix_list = File.readlines('db/suffix_list.txt', chomp: true)
  end

  # ensures all fields are filled and valid
  if @user.valid?
    # ensures the email suffix is on the whitelist
    if suffix_list.include?(@user.email.split('@')[1])
      unless @user.taken?
        # if no errors, saves user to the database and redirects to the login page
        @user.save_changes
        redirect '/login'
      end
    else
      @user.errors.add('email', 'must be a permitted University email address.')
    end
  end

  # if any errors, returns register page with errors displayed
  @error = 'Please correct the information below'
  erb :register
end
