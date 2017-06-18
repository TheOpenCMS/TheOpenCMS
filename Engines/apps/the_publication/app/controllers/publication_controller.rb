class PublicationController
  class RecordNotFound < StandardError; end

  class Base < ApplicationController
    authorize_resource_name :pub

    include ::ThePublication::ControllerLayout
    include ::ThePublication::ControllerCallbacks
    include ::ThePublication::ControllerCustomViewRender
    # include ::TheSortableTreeController::ReversedRebuild

    #################################
    # Public
    #################################

    def index
      @resources = @resource_class
                .with_user
                .published
                .simple_sort(params)
                .pagination(params)

      @pubs = @resources
    end

    def show;  end
    def print; end

    #################################
    # Restricted
    #################################

    def new
      @pub = @resource_class.new(user: current_user)
    end

    def create
      pub_params = permitted_params.merge(user: current_user)

      @pub = @resource_class.new(pub_params)
      @pub.content_processing_for(current_user)

      if @pub.save
        redirect_to url_for([:edit, @pub]), notice: "Publication has been created"
        return
      end
    end

    private

    def authorize_fallback_location
      request.referer || articles_path
    end
  end # Base
end
