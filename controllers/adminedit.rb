# frozen_string_literal: true

# Allows admins to edit mentees, by searching via ID
get '/adminedit' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @mentee = Mentee[params['id']]
    erb :adminedit
  else
    redirect '/loginadmin'
  end
end

# Allows admins to edit mentees, by searching via ID
post '/adminedit' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @mentee = Mentee[params['id']]

    unless @mentee.nil?
      @mentee.load(params)
      # If the changes are valid, save and return to the adminsearch page
      if @mentee.valid?
        @mentee.save_changes
        redirect '/adminsearch'
      end
    end

    erb :adminedit
  end
end

# Allows admins to edit mentors, by searching via ID
get '/adminedit_mentor' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @mentor = Mentor[params['id']]
    erb :adminedit_mentor
  else
    redirect '/loginadmin'
  end
end

# Allows admins to edit mentors, by searching via ID
post '/adminedit_mentor' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @mentor = Mentor[params['id']]

    unless @mentor.nil?
      @mentor.load(params)

      # If the changes are valid, save and return to the adminsearch page
      if @mentor.valid?
        @mentor.save_changes
        redirect '/adminsearch'
      end
    end

    erb :adminedit_mentor
  end
end
