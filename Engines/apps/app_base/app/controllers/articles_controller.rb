class ArticlesController < ::PublicationController::Base
  # There may be your specific code

  def index
    super
    render(template: 'pubs/index')
  end

  def show
    super

    render_custom_view(
      template: 'pubs/index',
      publication: @pub
    )
  end
end
