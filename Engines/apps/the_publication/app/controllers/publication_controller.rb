# include ::TheSortableTreeController::ReversedRebuild

class PublicationController
  class RecordNotFound < StandardError; end

  class Base < ApplicationController
    authorize_resource_name :pub
    layout ->{ publication_layout }

    include ::ThePublication::RenderCustomView
    before_action :set_pub_klass

    before_action :set_pub
    before_action :set_user
    before_action :increment_pub_counter!, only: :show

    skip_before_action :authenticate_user!, if: :skip_authenticate_user?
    skip_before_action :authorize_action!,  if: :skip_authorize_action?
    skip_before_action :set_resource!,      if: :skip_set_resource?
    skip_before_action :authorize_owner!,   if: :skip_authorize_owner?
    skip_before_action :authorize_admin!,   if: :skip_authorize_admin?

    def index
      @pubs = @klass
                .with_user
                .available_for(current_user)
                .simple_sort(params)
                .pagination(params)
    end

    def show; end

    def print
      render layout: false, template: 'the_pubs/pubs/print'
    end

    private

    def set_pub_klass
      @klass = controller_name.classify.constantize
      @klass_name = controller_name.singularize.to_sym
    end

    def set_pub
      pub_id = permitted_params(action: :pub_id)

      @pub = @klass.first
              .with_user
              .available_for(current_user)
              .friendly_first(pub_id)

      raise ThePublication::RecordNotFound.new unless @pub
    end

    def set_user
      @user = @pub.user
    end

    def increment_pub_counter!
      if @pub.published? && !@pub.owner?(current_user)
        @klass.increment_counter(:view_counter, @pub.id)
      end
    end

    # Layout

    def publication_layout
      return 'the_publication_frontend' if %w[index].include?(action_name)
      'the_publication_backend'
    end

    # Authintication White List

    def skip_authenticate_user?
      %w[index].include?(action_name)
    end

    def skip_authorize_action?
      %w[index].include?(action_name)
    end

    def skip_set_resource?
      %w[index].include?(action_name)
    end

    def skip_authorize_owner?
      %w[index].include?(action_name)
    end

    def skip_authorize_admin?
      %w[index].include?(action_name)
    end
  end # class Base
end # PublicationController
