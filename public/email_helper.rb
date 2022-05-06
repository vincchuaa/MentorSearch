def send_email(params)
  # ensures email is in a valid format
  def validate_email_address(email_address)
    email_address =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end
  
  # sends the email over the sheffield email server
  def send_mail(reciever, subject, body, email)
    response = Net::HTTP.post_form(URI("http://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"), 
      "recipients" => reciever,
      "subject" => subject,
      "body" => body,
      "submitter" => email)
    # returns whether the email successfully sent
    response.is_a? Net::HTTPSuccess
  end
  
  # only attempts to send if emails are valid. returns false if invalid or fails to send.
  if validate_email_address(params["recipient"]) && validate_email_address(params["sender"])
    # executes email and returns whether it succeeded
    send_mail(params["reciever"], params["subject"], params["body"], params["email"])
  else
    false
  end
end