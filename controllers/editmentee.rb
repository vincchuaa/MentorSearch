# frozen_string_literal: true

# Allows mentees to change their own details
get '/editmentee' do
  # as some mentees / mentors can share a user id, ensure user is Mentee
  if session[:user_type] == 'Mentee'
    @mentee = Mentee[session[:user_id]]
    if !@mentee.nil?
      erb :editmentee
    else
      redirect '/'
    end
  else
    redirect '/'
  end
end

post '/editmentee' do
  # loads current user if they are a mentee
  @mentee = Mentee[session[:user_id]] if session[:user_type] == 'Mentee'

  if !@mentee.nil?
    # stores mentee details before loading the edits
    original_email = @mentee.email
    original_username = @mentee.username
    @mentee.load(params)

    # checks the email is unique if it has been edited
    if original_email != @mentee.email && @mentee.email_taken?
      @mentee.errors.add('email', 'is already taken')
    end

    if original_username != @mentee.username && @mentee.username_taken?
      @mentee.errors.add('username', 'is already taken')
    end

    if @mentee.errors.empty? && @mentee.valid?
      @mentee.save_changes
      redirect '/profile'
    end

    # if invalid, return editmentee page with errors
    erb :editmentee
  else
    redirect '/'
  end
end
