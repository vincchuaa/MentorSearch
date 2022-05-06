# frozen_string_literal: true

# sends email to the admin containing their email so admin can change password
get '/forgotpassword' do
  erb :forgotpassword
end

post '/forgot_password' do
  # there will only be one admin, they will recieve this email
  @admin = Admin.first(id: 1)
  # sends email to the admin, requesting a password reset
  forgot_password = { 'recipient' => @admin.email,
                      'subject' => params['subject'],
                      'body' => params['body'],
                      'sender' => params['sender'] }
  send_email(forgot_password)
  redirect '/'
end
