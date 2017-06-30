class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ::ActivePermits::Controller

  include ::LocaleHelpers
  include ::AuthorizationHelpers
  rescue_from ::ActivePermits::AuthorizationException, with: :access_denied

  before_action :set_locale
  before_action -> { @user = current_user }
end
