# frozen_string_literal: true

# Gems
require 'sequel'
require 'logger'

# if environment not defined, default to test database
type = ENV.fetch('APP_ENV', 'test')

# find database path
db_path = File.dirname(__FILE__)
db = "#{db_path}/#{type}.sqlite3"

# add path for log file
log_path = "#{File.dirname(__FILE__)}/../log/"
log = "#{log_path}/#{type}.log"

# create new dir if log directory is not present
Dir.mkdir(log_path) unless File.exist?(log_path)

# creates the db
DB = Sequel.sqlite(db, logger: Logger.new(log))
