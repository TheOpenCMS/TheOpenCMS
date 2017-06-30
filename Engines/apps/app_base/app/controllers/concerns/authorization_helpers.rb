module AuthorizationHelpers
  extend ActiveSupport::Concern

  included do
    private

    def authorize_fallback_location
      request.referer || root_path
    end
  end

  def set_role!
    @role = current_user.try(:admin?) ? :admin : :user
  end

  def set_resource_class!
    @resource_class = controller_name.classify.constantize
    @resource_class_name = controller_name.singularize.to_sym
  end

  def needs_authorization?
    !devise_controller?
  end

  def access_denied
    redirect_back fallback_location: authorize_fallback_location,
      flash: {error: t('active_permits.access_denied')}
  end
end
