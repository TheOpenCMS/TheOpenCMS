module RoleSystem
  extend ActiveSupport::Concern

  # included do; end

  class_methods do
    def root
      @@root ||= ::User.first
    end
  end

  def admin?
    self == ::User.root
  end

  def owner? obj
    return true if admin?

    return id == obj.id      if obj.is_a?(User)
    return id == obj.user_id if obj.respond_to?(:user_id)

    false
  end
end
