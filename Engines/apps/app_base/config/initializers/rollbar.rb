voiceless do
  require 'rollbar'

  if Rails.env.production?
    if (rollbar_token = ::Settings.services.rollbar.token).present?
      Rollbar.configure do |config|
        config.access_token = rollbar_token
      end
    end
  end
end
