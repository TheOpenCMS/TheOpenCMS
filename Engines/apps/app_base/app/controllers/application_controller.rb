class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ::AuthorizeIt::Controller

  include ::LocaleHelpers
  include ::AuthorizationHelpers
  rescue_from ::AuthorizeIt::AuthorizationException, with: :access_denied

  before_action :set_locale
  before_action -> { @user = current_user }
end
