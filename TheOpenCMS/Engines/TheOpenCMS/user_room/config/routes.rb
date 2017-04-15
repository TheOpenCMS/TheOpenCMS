module UserRoom
  # include ::UserRoom::Routes.mixin(self)
  class Routes
    def self.mixin mapper
      mapper.extend ::UserRoom::DefaultRoutes
      mapper.send :user_room_routes
    end
  end

  module DefaultRoutes
    def user_room_routes
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
      get  "profile"       => "users#profile",       as: :profile
      post "autologin/:id" => 'users#autologin',     as: :autologin

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
    end
  end
end
