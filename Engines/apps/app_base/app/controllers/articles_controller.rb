class ArticlesController < ::PublicationController::Base
  # There may be your specific code

  #################################
  # Public
  #################################

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

  #################################
  # Restricted
  #################################

  def new
    super
    render(template: 'pubs/new')
  end

  def create
    super
    render(template: 'pubs/new') unless performed?
  end

  def edit
    super
    render(template: 'pubs/edit')
  end

  private

  def authorize_fallback_location
    request.referer || articles_path
  end
end
