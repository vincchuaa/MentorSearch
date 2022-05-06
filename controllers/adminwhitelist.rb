# frozen_string_literal: true

# Gets the email suffix list
get '/admin_whitelist' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    @suffix_list = []
    if File.exist?('db/suffix_list.txt')
      @suffix_list = File.readlines('db/suffix_list.txt', chomp: true)
    end
    erb :admin_whitelist
  else
    redirect '/loginadmin'
  end
end

# Allows an adming to remove an email suffix from the file
get '/admin_whitelist_remove' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    suffix = params['suffix']

    # Checks that the suffix file exists and can be editted
    @suffix_list = []
    if File.exist?('db/suffix_list.txt')
      @suffix_list = File.readlines('db/suffix_list.txt', chomp: true)
    end

    # Checks if the given suffix exists, then deletes it
    if @suffix_list.include? suffix
      @suffix_list.delete(suffix)
      IO.write('db/suffix_list.txt', @suffix_list.join("\n"))
    end
  end
  redirect '/admin_whitelist'
end

# Allows an adming to add an email suffix to the file
post '/admin_whitelist_add' do
  if session[:logged_in] && session[:user_type] == 'Admin'
    suffix = params['suffix']

    # Checks that the suffix file exists and can be editted
    @suffix_list = []
    if File.exist?('db/suffix_list.txt')
      @suffix_list = File.readlines('db/suffix_list.txt', chomp: true)
    end

    # Adds the given suffix
    @suffix_list.push(suffix)
    IO.write('db/suffix_list.txt', @suffix_list.join("\n"))
  end

  redirect '/admin_whitelist'
end
