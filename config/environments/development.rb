InitialRelease::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = true

  # Expands the lines which load the assets
  config.assets.debug = true

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
        :openssl_verify_mode  => 'none',
        :enable_starttls_auto => true, #works in ruby 1.8.7 and above
        :address => 'smtp.locum.ru',
        :port => 2525,
        #:domain => 'smtp.locum.ru',
        :authentication => :plain,
        :user_name => 'sender@mlip.ru',
        :password => 'qwer1234vcxz'#,
        #:enable_starttls_auto => true
    }
    
end
