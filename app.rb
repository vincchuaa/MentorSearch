# frozen_string_literal: true

# test or production mode set here
# only set if ENV not defined, as this would switch automatic tests to 'production' mode otherwise
type = ENV.fetch('APP_ENV', 'production')
ENV['APP_ENV'] = type


require 'sinatra'
require 'sinatra/reloader'
require 'require_all'
require "net/http"

# database users file
require_relative 'db/db'

# sessions
enable :sessions
set :session_key, '73a90acaae2b1ccc0e969709665bc62f'
set :bind, '0.0.0.0'

include ERB::Util

enable :raise_errors
enable :show_exceptions

if ENV['APP_ENV'] != 'test'
  disable :raise_errors
  disable :show_exceptions
end

require_all 'controllers'
require_all 'models'
require_relative 'public/email_helper.rb'

