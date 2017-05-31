class ApplicationController < ActionController::Base
  ACCEPTABLE_LOCALES = %w[ru en]
  include ::AuthorizeIt::Controller
  rescue_from ::AuthorizeIt::NotAuthorized, with: :access_denied

  protect_from_forgery with: :exception

  before_action :set_user
  before_action :set_locale

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

  def set_user
    @user = current_user
  end

  def set_locale
    I18n.locale = locale_param
  end

  def has_locale_param?
    locale = get_locale_param
    locale.present? && ACCEPTABLE_LOCALES.include?(locale)
  end

  def locale_param
    # TODO: request.env['HTTP_ACCEPT_LANGUAGE']
    locale = get_locale_param
    session[:locale] = locale if has_locale_param?
    session[:locale] || @user.try(:locale) || I18n.default_locale
  end

  def get_locale_param
    params[:locale].to_s.downcase
  end
end
