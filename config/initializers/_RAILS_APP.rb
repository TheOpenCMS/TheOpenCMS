app = Rails.application

# Time
::Time.zone = Settings.app.time_zone
app.config.time_zone = Settings.app.time_zone

# Locales
app.config.i18n.default_locale = Settings.app.default_locale

# Delayed processing
app.config.active_job.queue_adapter = :sidekiq

# RAILS APP secrets
# Rails.application.secrets
#
# Be sure to restart your server when you modify this file.
#
# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
#
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rails secret` to generate a secure secret key.
#
app.config.secret_key_base = Settings.app.secret_key_base
app.config.secret_token    = Settings.app.secret_token
