# frozen_string_literal: true

# Choose between registering as mentee or mentor
get '/choose' do
  erb :choose
end

# Choose between logging in as mentee or mentor
get '/chooselogin' do
  erb :chooselogin
end
