module LocaleHelpers
  ACCEPTABLE_LOCALES = %w[ru en]

  private

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
