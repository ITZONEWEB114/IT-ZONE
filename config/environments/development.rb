Web::Application.configure do
  config.action_mailer.delivery_method = :smtp
  
  config.action_mailer.smtp_settings={
    :address => "smtp.gmail.com",
    :port => 587,
    :domain =>"domain.of.sender.net",
    :authentication => "plain",
    :user_name => "wuningzhi",
    :password =>"19910629",
    :enable_starttls_auto => true
  }
end
 
