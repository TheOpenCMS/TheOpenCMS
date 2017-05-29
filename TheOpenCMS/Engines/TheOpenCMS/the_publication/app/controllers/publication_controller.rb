class PublicationController
  class RecordNotFound < StandardError; end

  class Base < ApplicationController
    # include ::TheSortableTreeController::ReversedRebuild
    include ::ThePublication::RenderCustomView

    authorize_resource_name :pub
    layout ->{ publication_layout }

    before_action :set_pub_klass
    before_action :set_authorize_resource_name

    before_action :set_pub
    before_action :set_user

    before_action :increment_publication_counter!, only: :show

    def show; end

    def print
      render layout: false, template: 'the_pubs/pubs/print'
    end

    private

    def set_pub_klass
      @klass = controller_name.classify.constantize
      @klass_name = controller_name.singularize.to_sym
    end

    def pub_id
      permitted_params(action: :pub_id)
    end

    def set_pub
      @pub = @klass.first
              .with_user
              .available_pub_for(current_user)
              .friendly_first(pub_id)

      raise ThePublication::RecordNotFound.new unless @pub
    end

    def set_user
      @user = @pub.user
    end

    def increment_publication_counter
      if @pub.published? && !@pub.owner?(current_user)
        @klass.increment_counter(:view_counter, @pub.id)
      end
    end
  end # class Base
end # PublicationController
