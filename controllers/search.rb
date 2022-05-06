# frozen_string_literal: true

# Controls the ability to search for mentors as a mentee
get '/search' do
  # stores whether a search has been made for the view.
  @searched = false
  @search_field = params['search_field']
  # searches the database for mentors whose domain matches the query
  @mentor_count = Mentor.where(Sequel.like(:domain, "%#{@search_field}%".upcase)).count

  # prepares 'no matches' message only if the query is not blank
  unless @search_field.nil?
    @no_mentors = 'No mentors match your search'
    @searched = true
  end

  # only shows the avaliable mentors if the user is logged in
  if session[:logged_in] == true
    # whether the mentee has already sent a request, to prevent extra requests
    @mentee_available = Request.first(mentee_id: session[:user_id]).nil?
    @mentors = Mentor.where(Sequel.like(:domain, "%#{@search_field}%".upcase))
    @email_query = '?subject=MentorSearch%20Mentee%20Request&body=Hi,%20I%20would%20like%20to%20request%20a%20meeting%20with%20you.'
  end

  # refreshes the page to show the mentors that match the search
  erb :search
end

# sends a request to the selected mentor
get '/request/*' do
  if session[:logged_in] == true
    @request_new = Request.new
    @request_new.load('mentor_id' => params[:splat][0].to_s, 'mentee_id' => session[:user_id].to_s)

    # stores whether the mentee has already sent a request
    @mentee_available = Request.first(mentee_id: session[:user_id]).nil?

    @mentor = Mentor.first(id: params[:splat][0].to_s)

    # only stores the request if there are no existing requests from this mentee
    # and it is not a duplicate request
    @request_new.save_changes if @mentee_available && !@request_new.taken?
  end

  # notifies the mentor that they have recieved a request
  notification_email = { 'recipient' => @mentor.email,
                         'subject' => 'New pair request recieved',
                         'body' => "You have recieved a pair request from #{session[:username]}. Please visit your profile on MentorSearch to accept.",
                         'sender' => session[:email] }
  send_email(notification_email)

  redirect '/search'
end

post '/email_mentor' do
  # sends an email to the mentor, asking to have a meeting before deciding to pair
  request_meeting = { 'recipient' => params['recipient'],
                      'subject' => params['subject'],
                      'body' => params['body'],
                      'sender' => params['sender'] }
  send_email(request_meeting)

  redirect '/search'
end

# Allows the user to log out
get '/logout' do
  session.clear
  redirect '/search'
end
