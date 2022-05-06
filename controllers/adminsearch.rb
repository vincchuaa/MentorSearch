# frozen_string_literal: true

get '/adminsearch' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @email_search = params.fetch('email_search', '').strip

    # displays mentees based on the search criteria
    @mentees = if @email_search.empty?
                 Mentee.all
               else
                 Mentee.where(Sequel.like(:email, "%#{@email_search}%"))
               end

    # displays mentors based on the search criteria
    @email_search_mentor = params.fetch('email_search_mentor', '').strip
    @mentors = if @email_search_mentor.empty?
                 Mentor.all
               else
                 Mentor.where(Sequel.like(:email, "%#{@email_search_mentor}%"))
               end
    erb :adminsearch
  else
    redirect '/loginadmin'
  end
end

get '/logout_admin' do
  session.clear
  redirect '/loginadmin'
end
