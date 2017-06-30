class WelcomeController < ApplicationController
  layout 'layouts/app_theme_frontend'

  before_action :authenticate_user!,  if: :needs_authenticate_user?
  before_action :authorize_action!,   if: :needs_authorize_action?

  def index; end
  def create_new; end

  private

  ################################################
  # Authorization
  ################################################

  def authorize_action!
    return if can_perform?(:welcome, action: action_name)
    authorization_exception!('Action is not allowed to perform')
  end

  ################################################
  # Do We Need to Perform a Callback?
  ################################################

  def needs_authenticate_user?
     except_actions = %w[index]
    !except_actions.include?(action_name)
  end

  def needs_authorize_action?
     except_actions = %w[index]
    !except_actions.include?(action_name)
  end
end
