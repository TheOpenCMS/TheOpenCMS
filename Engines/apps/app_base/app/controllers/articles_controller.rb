class ArticlesController < ::PublicationController::Base
  # There may be your specific code

  def index
    super
    render(template: 'pubs/index')
  end

  def show
    super
    render_custom_view(template: 'pubs/show', publication: @pub)
  end

  def print
    super
    render(template: 'pubs/print')
  end

  def new
    super
    render(template: 'pubs/new')
  end
end
