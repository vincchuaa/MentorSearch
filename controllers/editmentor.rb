# frozen_string_literal: true

# Allows mentors to change their own details
get '/editmentor' do
  # as some mentees / mentors can share a user id, ensure user is Mentor
  if session[:user_type] == 'Mentor'
    @mentor = Mentor[session[:user_id]]
    if !@mentor.nil?
      erb :editmentor
    else
      redirect '/'
    end
  else
    redirect '/'
  end
end

post '/editmentor' do
  # loads current user if they are a mentor
  @mentor = Mentor[session[:user_id]] if session[:user_type] == 'Mentor'

  if !@mentor.nil?
    # stores mentor details before loading the edits
    original_email = @mentor.email
    original_username = @mentor.username
    @mentor.load(params)

    # checks the email is unique if it has been edited
    if original_email != @mentor.email && @mentor.email_taken?
      @mentor.errors.add('email', 'is already taken.')
    end

    if original_username != @mentor.username && @mentor.username_taken?
      @mentor.errors.add('username', 'is already taken.')
    end

    if @mentor.errors.empty? && @mentor.valid?
      @mentor.save_changes
      redirect '/profile'
    end

    # if invalid, return editmentor page with errors
    erb :editmentor
  else
    redirect '/'
  end
end
