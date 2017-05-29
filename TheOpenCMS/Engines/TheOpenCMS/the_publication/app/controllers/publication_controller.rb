class PublicationController
  class RecordNotFound < StandardError; end

  class Base < ApplicationController
    # include ::TheSortableTreeController::ReversedRebuild

    authorize_resource_name :pub
    layout ->{ publication_layout }

    before_action :set_pub_klass
    before_action :set_authorize_resource_name

    before_action :set_pub
    before_action :set_user

    def show
      increment_publication_counter!
    end

    def print
      render layout: false, template: 'the_publication/pubs/print'
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
              # .with_users
              # .available_pub_for(current_user)
              # .friendly_first(pub_id)

      raise ThePublication::RecordNotFound.new unless @pub
    end

    def set_user
      @user = @pub.user
    end

    def render_custom_view opts = {}
      opts = opts.with_indifferent_access

      layout   = opts[:default_layout]
      template = opts[:default_template]
      pub      = opts[:publication]

      if pub
        layout   = pub.view_layout   if pub.view_layout.present?
        template = pub.view_template if pub.view_template.present?
      end

      if layout.present? || template.present?
        render({ layout: layout, template: template }.compact)
      end
    end

    def increment_publication_counter
      if @pub.published? && !@pub.owner?(current_user)
        @klass.increment_counter(:view_counter, @pub.id)
      end
    end
  end # class Base
end
