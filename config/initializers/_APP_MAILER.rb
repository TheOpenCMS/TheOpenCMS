app = Rails.application

config = app.config
mailer_config = ::Settings.app.mailer

# localhost:300/rails/mailers
if Rails.env.development?
  config.action_mailer.preview_path = "#{ Rails.root }/app/mailers"
end

# ======================================================
# Mailer settings
# ======================================================

config.action_mailer.default_url_options = { host: mailer_config.host }

case mailer_config.service
  when 'smtp'
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = mailer_config.smtp.default.to_h

  when 'sandmail'
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.sendmail_settings = mailer_config.sandmail.to_h

  when 'mailcatcher'
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = mailer_config.mailcatcher.to_h

  when 'letter_opener'
    config.action_mailer.delivery_method = :letter_opener

  else
    config.action_mailer.delivery_method = :test
    config.action_mailer.raise_delivery_errors = false
end
