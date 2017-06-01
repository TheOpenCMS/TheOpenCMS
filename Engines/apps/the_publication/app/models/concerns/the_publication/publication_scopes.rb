# include ::ThePublication::PublicationScopes
module ThePublication
  module PublicationScopes
    extend ActiveSupport::Concern

    included do
      scope :with_user, -> { includes(:user) }
      scope :available_for, ->(user = nil) { user ? for_manage : published }
    end
  end
end
