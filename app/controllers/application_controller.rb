class ApplicationController < ActionController::Base
  include ::AuthorizeIt::Controller
  protect_from_forgery with: :exception

  before_action -> { @user = current_user }
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_resource!,      unless: :devise_controller?
  before_action :authorize_owner!,   unless: :devise_controller?
  before_action :authorize_admin!,   unless: :devise_controller?
end
