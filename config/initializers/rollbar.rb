voiceless do
  require 'rollbar'

  if Rails.env.production?
    Rollbar.configure do |config|
      config.access_token = ::Settings.services.rollbar.token
    end
  end
end
