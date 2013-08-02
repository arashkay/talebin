ActionMailer::Base.add_delivery_method :smtp #:active_record, ArMailerRails3::ActiveRecord, :email_class => Email
ActionMailer::Base.delivery_method = :active_record
ActionMailer::Base.smtp_settings = {
      :address => 'mail.talebin.com',
      :port => 587,
      :domain => 'talebin.com',
      :authentication => :login,
      :user_name => 'noreply@talebin.com',
      :password => 'zaz_419Z',
      :enable_starttls_auto => false
    }
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true
#ActionMailer::Base.default_charset = 'utf-8'
