class DeviseControllers::ConfirmationsController < Devise::ConfirmationsController
  include DeviseHelper

  protected

  def after_confirmation_path_for(resource_name, resource)
    sign_in resource
    cabinet_url
  end

  # The path used after confirmation.
  #
  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      signed_in_root_path(resource)
    else
      new_session_path(resource_name)
    end
  end
end
