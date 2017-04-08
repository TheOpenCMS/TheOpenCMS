if defined? Settings
  Devise.setup do |config|
    # config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
    config.mailer_sender = Settings.devise.mailer_sender

    # config.mailer = 'Devise::Mailer'
    config.mailer = Settings.devise.mailer
  end
end
