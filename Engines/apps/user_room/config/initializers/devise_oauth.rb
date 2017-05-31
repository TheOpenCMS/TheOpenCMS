if defined? Settings
  Devise.setup do |config|
    config.omniauth :vkontakte,
      Settings.oauth.try(:vkontakte).try(:app_id),
      Settings.oauth.try(:vkontakte).try(:app_secret),
      display: 'popup'

    config.omniauth :facebook,
      Settings.oauth.try(:facebook).try(:app_id),
      Settings.oauth.try(:facebook).try(:app_secret),
      scope:   'public_profile,user_friends,email',
      display: 'popup'

    config.omniauth :twitter,
      Settings.oauth.try(:twitter).try(:app_id),
      Settings.oauth.try(:twitter).try(:app_secret)

    config.omniauth :google_oauth2,
      Settings.oauth.try(:google_oauth2).try(:app_id),
      Settings.oauth.try(:google_oauth2).try(:app_secret),
      scope:   'email, profile, plus.me',
      prompt:  'select_account',
      image_aspect_ratio: :square,
      image_size: 50,
      display: 'popup',
      skip_jwt: true

    # http://example.com/auth/odnoklassniki/callback
    config.omniauth :odnoklassniki,
      Settings.oauth.try(:odnoklassniki).try(:app_id),
      Settings.oauth.try(:odnoklassniki).try(:app_secret),
      public_key: Settings.oauth.try(:odnoklassniki).try(:app_public),
      scope: 'VALUABLE_ACCESS'
  end
end
