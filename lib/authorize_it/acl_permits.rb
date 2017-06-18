module AuthorizeIt::ACLPermits
  # class ArticleACL::Update < AuthorizeIt::ACLPermits::Base
  #   def can_perform?
  #     return true if @user.admin?
  #
  #     acl = {
  #       user: %w[ index show ]
  #       editor: %w[ index show edit update destroy]
  #     }
  #
  #     role = @user.editor? ? :editor : :user
  #     acl.include?(@controller.action_name)
  #   end
  # end

  # ArticleACL::Update.new(
  #   user: current_user,
  #   action: 'update',
  # ).can_perform?

  class Base
    def initialize(options = {})
      @options = options
      @controller = options[:controller]

      @user = options[:user]
      @scope = options[:scope]
      @action = options[:action]
      @resource = options[:resource]
    end
  end

  private

  #################################
  # Controller Helper
  #################################

  def can_perform?(options = {})
    user = options.fetch(:user, self.try(:current_user))
    scope = options.fetch(:scope, self.try(:controller_name))
    action = options.fetch(:action, self.try(:action_name))
    resource = options.fetch(:resource, nil)

    options = options.merge({
      user: user,
      scope: scope,
      action: action,
      resource: resource,
      controller: self
    })

    acl_klass_name = "#{ scope.singularize.to_s.classify }ACL::#{ action.to_s.classify }"
    acl_klass = acl_klass_name.constantize

    acl_klass.new(options).can_perform?
  end
end
