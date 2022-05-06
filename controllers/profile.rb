# frozen_string_literal: true

get '/profile' do
  if session[:logged_in]
    if session[:user_type] == 'Mentor'
      @user = Mentor.first(id: session[:user_id])
      # retrieves all the pending requests for view to display
      @request_ids = Request.where(mentor_id: session[:user_id])
      # deletes every expired request (request thats not been accepted for more than 7 days)
      @request_ids.each do |request|
        request.remove_expired
      end
      @request_count = @request_ids.count
    elsif session[:user_type] == 'Mentee'
      @user = Mentee.first(id: session[:user_id])
      # retrieves outgoing pending request for view to display
      @request_ids = Request.where(mentee_id: session[:user_id])
      # deletes every expired request (request thats not been accepted for more than 7 days)
      @request_ids.each do |request|
        request.remove_expired
      end
      @request_count = @request_ids.count
    else
      @user = Admin.first(id: session[:user_id])
    end
  else
    redirect '/'
  end
  
  erb :profile
end

get '/accept_mentee' do
  @accepted_mentee = params['id']
  # finds and accepts the pending request of the selected mentee
  @request_to_accept = Request[mentor_id: session[:user_id], mentee_id: @accepted_mentee]
  @request_to_accept.accept
  
  # sets mentors availability to unavailable after accepting a request
  @mentor = Mentor[session[:user_id]]
  @mentor.unavailable
  redirect '/profile'
end

post '/set_availability' do
  @mentor = Mentor[session[:user_id]]
  if params['availability'] == 'available'
    @mentor.available
  else
    @mentor.unavailable
  end
  redirect '/profile'
end

get '/cancel_request' do
  # finds and deletes the selected request
  request_to_cancel = Request[mentor_id: params['id'], mentee_id: session[:user_id]]
  request_to_cancel.delete unless request_to_cancel.nil?
  redirect '/profile'
end

get '/logout_mentor' do
  session.clear
  redirect '/'
end
