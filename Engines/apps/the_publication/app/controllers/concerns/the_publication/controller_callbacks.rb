# include ::ThePublication::ControllerCallbacks

module ThePublication
  module ControllerCallbacks
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!,  if: :needs_authenticate_user?
      before_action :authorize_action!,   if: :needs_authorize_action?

      before_action :set_resource_class!, if: :needs_set_resource_class?
      before_action :set_resource!,       if: :needs_set_resource?
      before_action :set_user!,           if: :needs_set_user?

      before_action :authorize_owner!,    if: :needs_authorize_owner?

      after_action :increment_view_counter!, if: :needs_increment_view_counter?
    end

    private

    ################################################
    # Authorization
    ################################################

    def authorize_action!
      return if can_perform?(:publication, action: action_name)
      authorization_exception!('Action is not allowed to perform')
    end

    def set_resource!
      pub_id = params.fetch(:id)

      @pub = @resource_class.with_user
                            .available_for(current_user)
                            .friendly_first(pub_id)

      @resource = @pub

      fail ::ThePublication::RecordNotFound.new unless @pub
    end

    def set_user!
      @user = @resource.user
    end

    def authorize_owner!
      owner = current_user.owner?(@resource)
      authorization_exception!('Owner required') unless owner
    end

    ################################################
    # Do We Need to Perform a Callback?
    ################################################

    def needs_authenticate_user?
       except_actions = %w[index show print]
      !except_actions.include?(action_name)
    end

    def needs_authorize_action?
       except_actions = %w[index print]
      !except_actions.include?(action_name)
    end

    def needs_set_resource_class?
       except_actions = %w[]
      !except_actions.include?(action_name)
    end

    def needs_set_resource?
       except_actions = %w[index new create my manage]
      !except_actions.include?(action_name)
    end

    def needs_set_user?
      except_actions = %w[index new create my manage]
     !except_actions.include?(action_name)
    end

    def needs_authorize_owner?
       except_actions = %w[index show print new create my manage]
      !except_actions.include?(action_name)
    end

    def needs_increment_view_counter?
      only_actions = %w[show print]
      only_actions.include?(action_name)
    end

    ################################################
    # After Actions
    ################################################

    def increment_view_counter!
      return if  @resource.user == current_user
      return if !@resource.published?
      @resource_class.increment_counter(:view_counter, @resource.id)
    end
  end
end
