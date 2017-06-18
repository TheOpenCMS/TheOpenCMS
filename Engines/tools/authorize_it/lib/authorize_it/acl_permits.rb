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
      @options = options.with_indifferent_access
      @controller = options[:controller]

      @user = options[:user]
      @resource = options[:resource]

      @scope = options[:scope]
      @acl = options[:acl]
      @action = options[:action]
    end
  end

  private

  #################################
  # Controller Helper
  #################################

  def can_perform?(options = {})
    user = options.fetch(:user, self.try(:current_user))
    resource = options.fetch(:resource, nil)

    scope  = options.fetch(:scope, self.try(:controller_name))
    action = options.fetch(:action, self.try(:action_name))
    acl    = options.fetch(:acl, :shared)

    options = options.merge({
      user: user,
      controller: self,
      resource: resource,

      scope: scope,
      acl: acl,
      action: action
    })

    acl_klass_name = "#{ scope.to_s.singularize.classify }ACL::#{ acl.to_s.classify }"
    acl_klass = acl_klass_name.constantize

    acl_klass.new(options).can_perform?
  end
end
