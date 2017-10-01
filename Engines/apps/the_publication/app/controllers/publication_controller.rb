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
      @pub = @resource_class.new(pub_params)
      @pub.content_processing_for(current_user)

      if @pub.save
        redirect_to \
          url_for([:edit, @pub]),
          notice: "Publication has been created"
      end
    end

    def edit; end

    def update
      @pub.assign_attributes(pub_params)
      @pub.content_processing_for(current_user)

      if @pub.save
        redirect_to \
          url_for([:edit, @pub]),
          notice: "Publication has been updated"
      end
    end

    def my
      @resources = @resource_class
                .with_user
                .where(user: current_user)
                .where(state: %w[draft published])
                .max2min(:created_at)
                .simple_sort(params)
                .pagination(params)

      @pubs = @resources
    end

    #################################
    # Admin Permissions
    #################################

    def manage
      @resources = @resource_class
                .with_user
                .draft.or(@resource_class.published)
                .max2min(:published_at)
                .simple_sort(params)
                .pagination(params)

      @pubs = @resources
    end

    private

    def pub_params
      permitted_params(class: :publication, action: :edit)
    end
  end # Base
end
