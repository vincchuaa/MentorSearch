# frozen_string_literal: true

# Suspends the mentee matching the given id
post '/suspend_mentee' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @mentee = Mentee[params['id']]
    @mentee.suspend unless @mentee.nil?
    redirect '/adminsearch'
  end
end

# Suspends the mentor matching the given id
post '/suspend_mentor' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @mentor = Mentor[params['id']]
    @mentor.suspend unless @mentor.nil?
    redirect '/adminsearch'
  end
end

# Sends an email to appeal a suspension
post '/suspension_appeal' do
  # Sends to first admin by default
  @admin = Admin.first(id: 1)
  suspension_appeal = { 'recipient' => @admin.email,
                        'subject' => params['subject'],
                        'body' => params['body'],
                        'sender' => params['sender'] }
  send_email(suspension_appeal)
  redirect '/'
end

get '/suspend' do
  erb :suspend
end
