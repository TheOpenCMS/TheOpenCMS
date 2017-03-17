class DeviseControllers::PasswordsController < Devise::PasswordsController
  layout 'user_room'
  skip_before_action :require_no_authentication, only: [:edit, :update]
end
