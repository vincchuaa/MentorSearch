# frozen_string_literal: true

# First pair are to catch errors if they occur
error 404 do
  erb :not_found
end

error 500 do
  erb :error500
end

# Second pair are to test the views for those pages
get '/not_found' do
  erb :not_found
end

get '/error500' do
  erb :error500
end
