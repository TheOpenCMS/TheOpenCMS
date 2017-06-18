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
    render(template: 'pubs/new')
  end
end
