# frozen_string_literal: true

# Restores mentee matching the given id
post '/restore_mentee' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @mentee = Mentee[params['id']]
    @mentee.restore unless @mentee.nil?
    redirect '/adminsearch'
  end
end

# Restores mentor matching the given id
post '/restore_mentor' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @mentor = Mentor[params['id']]
    @mentor.restore unless @mentor.nil?
    redirect '/adminsearch'
  end
end
