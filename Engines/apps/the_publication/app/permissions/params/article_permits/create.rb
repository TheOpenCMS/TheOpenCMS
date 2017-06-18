class ArticlePermits::Create < AuthorizeIt::PermittedParams::Base
  def permitted_params
    return @params.permit! if @controller.current_user.admin?

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
