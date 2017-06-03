class PublicationController
  class RecordNotFound < StandardError; end

  class Base < ApplicationController
    authorize_resource_name :pub

    include ::ThePublication::ControllerLayout
    include ::ThePublication::ControllerCallbacks
    include ::ThePublication::ControllerCustomViewRender
    # include ::TheSortableTreeController::ReversedRebuild

    def index
      @resources = @resource_class
                .with_user
                .available_for(current_user)
                .simple_sort(params)
                .pagination(params)

      @pubs = @resources
    end

    def show;  end
    def print; end

    private

    def authorize_fallback_location
      articles_path
    end

  end # Base
end
