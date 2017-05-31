class ArticlesController < ::PublicationController::Base
  # There may be your specific code

  def index
    super

    render_custom_view(
      default_layout:   'the_publication/layouts/index',
      default_template: 'the_publication/pubs/index'
    )
  end

  # def show
  #   super
  #
  #   render_custom_view(
  #     default_layout:   'pubs_frontend',
  #     default_template: 'the_pubs/show',
  #     publication: @pub
  #   )
  # end
end
