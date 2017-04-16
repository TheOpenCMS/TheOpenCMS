voiceless do
  if Rails.env.production?
    error_mailer = ::Settings.app.exception_notification

    app_name          = error_mailer.app_name
    sender_name       = error_mailer.sender_name
    sender_address    = error_mailer.sender_address
    recipient_address = error_mailer.recipient_address

    Rails.application.config.middleware.use(
      ExceptionNotification::Rack,
      email: {
        email_prefix: app_name,
        sender_address: %{"#{ sender_name }" <#{ sender_address }>},
        exception_recipients: [recipient_address]
      }
    )
  end
end
