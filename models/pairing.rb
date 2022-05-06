require 'logger'
require 'sequel'

class Request < Sequel::Model
  def load(params)
    self.mentor_id = params.fetch('mentor_id','').strip
    self.mentee_id = params.fetch('mentee_id','').strip
    # records time request was created
    self.time_stamp = Sequel.application_to_database_timestamp(DateTime.now())
    # if true, request becomes a mentee / mentor pairi
    self.paired = 0
  end
  
  def remove_expired() 
    # only deletes if the request isn't a pair / is not accepted
    if self.paired == 0
      # deletes a request record if it is older than 7 days
      if (Time.now - self.time_stamp)/ 86400 > 7
        self.delete
      end
    end
  end
  
  # retrieves either the mentee or mentor record corresponding to this request
  def get_user(user_type)
    if (user_type == 'Mentee')
      return Mentee.first(id: mentee_id)
    elsif (user_type == 'Mentor')
      return Mentor.first(id: mentor_id)
    end
  end
  
  # checks whether a request between the same pair already exists
  def taken?
    !Request.first(mentor_id: mentor_id, mentee_id: mentee_id).nil?
  end
  
  # makes the current request a pairing
  def accept()
    self.update(:paired => 1)
    # deletes all other requests for this mentor
    tests = Request.where(mentor_id: self.mentor_id).exclude(mentee_id: self.mentee_id).delete
  end
end