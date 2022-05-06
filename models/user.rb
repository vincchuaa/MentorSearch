# frozen_string_literal: true

require 'logger'
require 'sequel'

# Module containing common methods for Mentees and Mentors
module User
  def load(params)
    self.email = params.fetch('email', '').strip
    self.username = params.fetch('username', '').strip
    self.password = params.fetch('password', '').strip
  end

  # checks all necessary fields have been entered
  def validate
    errors.add('email', 'cannot be empty') if email.empty?
    errors.add('username', 'cannot be empty') if username.empty?
    errors.add('password', 'cannot be empty') if password.empty?
  end

  # checks whether username or email taken, adds appropriate errors.
  def taken?
    if username_taken?
      taken = true
      errors.add('username', 'is already taken.')
    end

    if email_taken?
      taken = true
      errors.add('email', 'is already taken.')
    end

    taken
  end

  # checks whether username already exists in mentees or mentors table
  def username_taken?
    !Mentee.first(username: username).nil? || !Mentor.first(username: username).nil?
  end

  # checks whether username already exists in mentees or mentors table
  def email_taken?
    !Mentee.first(email: email).nil? || !Mentor.first(email: email).nil?
  end

  # suspends the user, to prevent login
  def suspend
    update(suspended: 1)
  end

  # restores the user, enabling login
  def restore
    update(suspended: 0)
  end
end

# An Admin record from the database
class Admin < Sequel::Model
  include User

  def load(params)
    super
  end

  # checks if admin account exists
  def exist?
    compare = Admin.first(username: username)
    !compare.nil? && compare.password == password
  end
end

# A Mentee record from the database
class Mentee < Sequel::Model
  include User

  def exist?
    compare = Mentee.first(username: username)
    !compare.nil? && compare.password == password
  end

  def load(params)
    super
    self.suspended = params.fetch('suspended', '').strip
  end
end

# A Mentor record from the database
class Mentor < Sequel::Model
  include User

  def load(params)
    super
    self.firstname = params.fetch('firstname', '').strip
    self.lastname = params.fetch('lastname', '').strip
    self.domain = params.fetch('domain', '').strip
    self.suspended = params.fetch('suspended', '').strip
    self.availability = params.fetch('availability', '').strip
  end

  def validate
    super
    errors.add('firstname', 'cannot be empty!') if firstname.empty?
    errors.add('lastname', 'cannot be empty!') if lastname.empty?
    errors.add('domain', 'cannot be empty!') if domain.empty?
  end

  def exist?
    compare = Mentor.first(username: username)
    !compare.nil? && compare.password == password
  end

  def unavailable
    update(availability: 1)
  end

  def available
    update(availability: 0)
  end
end
