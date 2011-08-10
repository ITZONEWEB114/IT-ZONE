# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Depot::Application.initialize!

Depot::Application.configure do 
  config.action_mailer.delivery_method = :smtp 
  
  config.action_mailer.smtp_settings = {
    :address        =>  "smtp.gmail.com",
    :port           =>  587,
    :domain         =>  "domain.of.sender.net",
    :authentication =>  "plain",
    :user_name      =>  "liangzhenxiangsysu@gmail.com",
    :password       =>  "07110014",
    :enable_starttls_auto => true
  }
  config.action_mailer.default_url_options = { :host => "localhost:3000" }

end
