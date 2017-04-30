class ApplicationController < ActionController::Base
  include ::AuthorizeIt::Controller
  rescue_from ::AuthorizeIt::NotAuthorized, with: :access_denied

  protect_from_forgery with: :exception

  before_action -> { @user = current_user }
  before_action :authenticate_user!, if: :needs_authorization?
  before_action :authorize_action!,  if: :needs_authorization?
  before_action :set_resource!,      if: :needs_authorization?
  before_action :authorize_owner!,   if: :needs_authorization?
  before_action :authorize_admin!,   if: :needs_authorization?

  private

  def needs_authorization?
    !devise_controller?
  end

  def authorize_admin!
    authorization_exception! unless current_user.admin?
  end

  def access_denied
    redirect_back fallback_location: authorize_fallback_location,
      flash: {error: t('authorize_it.access_denied')}
  end
end
