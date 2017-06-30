class PublicationController
  class RecordNotFound < StandardError; end
end

class PublicationController
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
                .max2min(:published_at)
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
      edit_params = edit_params.merge(user: current_user)

      @pub = @resource_class.new(edit_params)
      @pub.content_processing_for(current_user)

      if @pub.save
        redirect_to \
          url_for([:edit, @pub]),
          notice: "Publication has been created"
      end
    end

    def edit; end

    def update
      @pub.assign_attributes(edit_params)
      @pub.content_processing_for(current_user)

      if @pub.save
        redirect_to \
          url_for([:edit, @pub]),
          notice: "Publication has been updated"
      end
    end

    private

    def edit_params
      permitted_params(class: :publication, action: :edit)
    end
  end # Base
end
