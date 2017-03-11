## UserRoom

This gem provides sign-in/log-in functionality and basic UI for User's cabinet

Out of the box it woks with some social networks logins.

* Vkontakte
* Odnoklassniki
* Facebook
* Twitter
* Google Plus

```
```


gem "user_room", path: './plugins/user_room'

# 1

rails generate config:install
rails generate devise:install
rails generate devise user

# 2

`config/initializers/devise.rb`

```rb
# config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
config.mailer_sender = 'mail-sender@example.com'

# config.mailer = 'Devise::Mailer'
config.mailer = 'DeviseMailer'
```

# 3

`config/routes.rb`

```rb
Rails.application.routes.draw do
  ##########################################################
  # DEVISE
  ##########################################################

  devise_for :users, path: '',
    :path_names => {
      sign_in:  'login',
      sign_up:  'signup',
      sign_out: 'logout'
    },
    :controllers => {
      :omniauth_callbacks => "devise_controllers/omniauth_callbacks",
      :confirmations      => "devise_controllers/confirmations",
      :registrations      => "devise_controllers/registrations",
      :sessions           => "devise_controllers/sessions",
      :passwords          => "devise_controllers/passwords"
    }

  devise_scope :user do
    get  'account_should_be_activate' => 'devise_controllers/registrations#account_should_be_activate'

    post 'create_email_registration_request'        => 'devise_controllers/registrations#create_email_registration_request',   as: :create_email_registration_request
    get  'activate_email_registration_request/:uid' => 'devise_controllers/registrations#activate_email_registration_request', as: :activate_email_registration_request

    post 'create_onetime_login_link'        => 'devise_controllers/sessions#create_onetime_login_link',   as: :create_onetime_login_link
    get  'activate_onetime_login_link/:uid' => 'devise_controllers/sessions#activate_onetime_login_link', as: :activate_onetime_login_link

    delete 'omniauth/provider/:provider' => 'devise_controllers/omniauth_callbacks#delete_provider', as: :delete_provider
  end

  # Personal
  get  "cabinet"       => "users#cabinet",       as: :cabinet
  post "autologin/:id" => 'users#autologin',     as: :autologin
  get  "admin_cabinet" => "users#admin_cabinet", as: :admin_cabinet

  resources :users, only: %w[ index show edit update ] do
    patch  :change_email
    patch  :change_password

    member do
      patch  :avatar_crop_1x1

      patch  :avatar_rotate_left
      patch  :avatar_rotate_right

      delete :avatar_delete
    end
  end

  ##########################################################
  # ~ DEVISE
  ##########################################################
end
```

# 5

`db/migrate/20151116162453_devise_create_users.rb`

```
  ## Database authenticatable
  ## Recoverable
  ## Rememberable
  ## Trackable
  ## Confirmable
```

# MIGRATIONS::
  > rake user_room_engine:install:migrations

```
000_user_room_socialnetworks.rb
001_user_room_add_avatar.rb
002_user_room_onetime_ligin_link.rb
004_user_room_email_registration_request.rb
005_user_room_credentials.rb
```

> rake db:migrate

# 6

`rails g controller users --skip-routes --test-framework=false --helper=false --assets=false`

```
class ApplicationController < ActionController::Base
  include ::UserRoom::ApplicationController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

class UsersController < ApplicationController
  include ::UserRoom::UsersController

  before_action :user_require,   except: %w[ index show new ]
  before_action :owner_required, except: %w[ index show new cabinet admin_cabinet autologin ]

  before_action :admin_require,
    except: %w[
      index show
      cabinet edit update
      avatar_crop avatar_delete
      change_password change_email
    ] + ::UserRoom::UserAvatarActions::ACTIONS_NAMES

  def cabinet
    # some code here
  end
end
```

App side check methods

```
user_require
owner_required
admin_require
```

# 7

app_view/views/user_room/layouts/items/header.html.slim

app_view/views/user_room/layouts/items/footer.html.slim

# 8

`config/settings/development.yml`

```
oauth:
  vkontakte:
    app_id:     4992342
    app_secret: dlYueTCkBlxUTUWoxPSs

  facebook:
    app_id:     257977205242635
    app_secret: 33dc289fa24cf022c1655219345a99fe

  twitter:
    app_id: OYxdq6kR8hfwhJRhbxg
    app_secret: ckRuKYAIOxzbG2rZPZ8OxKepMKgCBocnEfRq0jEUJX

  google_oauth2:
    app_id: '134546278725-qtnn70jluff912l4n0aitk4gle9qfgdb.apps.googleusercontent.com'
    app_secret: 'pv9oVKBj-_F5YTyU4gAUe4ny'

  odnoklassniki:
    app_id: 9972088231
    app_secret: 3D542DC1C1A70B3744C7CB72
    app_public: CBAMPOICEBABBAABA
```

# 9

`config/application.rb`

```rb
config.autoload_paths += %W[ #{ config.root }/app_view/mailers/concerns/** ]
config.action_mailer.preview_path = "#{ Rails.root }/app_view/mailers" if Rails.env.development?

# ======================================================
# Mailer settings
# ======================================================
config.action_mailer.default_url_options = { host: Settings.mailer.host }

if Settings.mailer.service == 'smtp'
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    address: Settings.mailer.smtp.default.address,
    domain:  Settings.mailer.smtp.default.domain,
    port:    Settings.mailer.smtp.default.port,

    user_name: Settings.mailer.smtp.default.user_name,
    password:  Settings.mailer.smtp.default.password,

    authentication: Settings.mailer.smtp.default.authentication,
    enable_starttls_auto: true
  }
elsif Settings.mailer.service == 'sandmail'
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.sendmail_settings = {
    location:  Settings.mailer.sandmail.location,
    arguments: Settings.mailer.sandmail.arguments
  }
else
  config.action_mailer.delivery_method = :test
  config.action_mailer.raise_delivery_errors = false
end
# ======================================================
#  ~ Mailer settings
# ======================================================
```

`config/settings/development.yml`

```rb
mailer:
  service: smtp
  host: 'localhost:3000'
  admin_email: 'admin@blog.com'

  sandmail:
    location:  '/usr/sbin/sendmail'
    arguments: '-i -t'

  smtp:
    default:
      user_name: 'mail-sender@example.com'
      password:  'password'

      authentication: plain
      address: 'smtp.yandex.ru'
      domain:  'yandex.ru'
      port:    25
```

`app_view/mailers/mailer_preview.rb`

```rb
# http://localhost:3000/rails/mailers

class MailerPreview < ActionMailer::Preview
  def DEVISE_reset_password_instructions
    DeviseMailer.reset_password_instructions(User.last, {})
  end

  def DEVISE_confirmation_instructions
    DeviseMailer.confirmation_instructions(User.last, {})
  end

  def DEVISE_MailRegistrationRequest
    reg_req = EmailRegistrationRequest.last
    DeviseMailer.mail_registration_request(reg_req.id, callback_path = '/orders/09dfr12')
  end

  def DEVISE_OnetimeLoginRequest
    log_req = OnetimeLoginLink.last
    DeviseMailer.onetime_login_request(log_req.id, callback_path = '/orders/09dfr12')
  end

  def DEVISE_New_user_created
    user_id = User.first.id
    DeviseMailer.new_user_created(user_id)
  end
end
```

```
EmailRegistrationRequest.create
OnetimeLoginLink.create
```

`app_view/mailers/devise_mailer.rb`

```
class DeviseMailer < Devise::Mailer
  include ::UserRoom::MailerSettingsConcern
  include ::UserRoom::DeviseMailerExtention

  private

  def set_attachments!
    # Add common attached files here

    # @images = {
    #   'logo.png'      => '/logos/w350_h100.png',
    #   'shop_logo.png' => '/logos/shop_w350_h100.png'
    # }
    # @images.each_pair do |name, path|
    #   attachments.inline[name] = File.read("#{ Rails.root }/public/#{ path }")
    # end
  end
end
```

`app_view/views/user_room/layouts/mailers/user_room.html.slim`

```rb
= yield
```

# 10

`config/initializers/premailer_rails.rb`

```rb
Premailer::Rails.config.merge!(
  preserve_styles: true,
  remove_classes: true,
  remove_ids: true
)
```
