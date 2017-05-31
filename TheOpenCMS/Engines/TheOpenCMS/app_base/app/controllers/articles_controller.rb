class ArticlesController < ::PublicationController::Base
  # There may be your specific code

  def index
    super
    render_custom_view(
      layout: 'app_theme/layouts/layout',
      template: 'pubs/index'
    )
  end

  def show
    super

    render_custom_view(
      layout: 'app_theme/layouts/',
      template: 'pubs/index',
      publication: @pub
    )
  end
end
