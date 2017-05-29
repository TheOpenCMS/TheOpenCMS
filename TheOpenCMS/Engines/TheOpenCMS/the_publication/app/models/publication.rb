class PublicationModel
  class Base < ApplicationRecord
    include ::ThePublication::PublicationStates
    include ::ThePublication::PublicationScopes

    include ::SimpleSort::Base
    include ::Pagination::Base
    include ::FriendlyIdPack::Base
    include ::Notifications::LocalizedErrors
  end
end
