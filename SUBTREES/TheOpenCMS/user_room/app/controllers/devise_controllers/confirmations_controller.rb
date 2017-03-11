class DeviseControllers::ConfirmationsController < Devise::ConfirmationsController
  include DeviseHelper

  protected

  def after_confirmation_path_for(resource_name, resource)
    sign_in resource
    cabinet_url
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  #
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

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
