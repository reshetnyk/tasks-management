ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address              =>  'smtp.sendgrid.net',
    :port                 =>  '587',
    :authentication       =>  :plain,
    :user_name            =>  'app145705082@heroku.com',
    :password             =>  'andcqdfh4840',
    :domain               =>  'rocky-island-44320.herokuapp.com',
    :enable_starttls_auto  =>  true
}