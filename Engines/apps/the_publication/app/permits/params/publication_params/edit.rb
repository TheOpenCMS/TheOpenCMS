class PublicationParams::Edit < ActivePermits::PermittedParams::Base
  def permitted_params
    params = @user.admin? ? admin_params : user_params
    params = params.merge(user: @user) if @action_name == 'create'
    params
  end

  private

  def admin_params
    @params.permit!
  end

  def user_params
    resource_class_name = controller_var('@resource_class_name')
    @params.require(resource_class_name).permit(
      :slug,

      :title,
      :raw_intro,
      :raw_content,

      :editor_type,
      :state,

      :view_layout,
      :view_template
    )
  end
end
