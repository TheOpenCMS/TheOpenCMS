class PublicationModel
  class Base < ApplicationRecord
    self.abstract_class = true

    include ::ThePublication::PublicationStates
    include ::ThePublication::PublicationScopes

    include ::SimpleSort::Base
    include ::Pagination::Base
    include ::FriendlyIdPack::Base
    include ::Notifications::LocalizedErrors

    belongs_to :user
  end
end
