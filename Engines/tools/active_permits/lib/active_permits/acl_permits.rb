module ActivePermits::ACLPermits

  # class ArticleACL < ActivePermits::ACLPermits::Base
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

  # ArticleACL.new(
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

  #################################
  # User Model Helper
  #################################

  # if @user.can_perform?(:article, action: :new)
  # if @user.can_perform?(:articles, action: :new)
  # if @user.can_perform?(@article, action: :new)
  # if @user.can_perform?('Article', action: :new)
  # if @user.can_perform?('Article', action: [:new, :edit])

  module User
    def can_perform?(resource, options = {})
      if %w[String Symbol].include?(resource.class.to_s)
        resource_class_name = resource.to_s
      else
        resource_class_name = resource.name
      end

      acl_klass_name = resource_class_name.downcase.classify
      acl_klass = "#{acl_klass_name}ACL".constantize

      resource = options.fetch(:resource, resource)
      action = options.fetch(:action)

      options = options.merge({
        resource: resource,
        action: action,
        user: self
      })

      acl_klass.new(options).can_perform?
    end
  end

  module Controller
    def can_perform?(resource, options = {})
      return false unless current_user
      current_user.can_perform?(resource, options)
    end
  end
end
