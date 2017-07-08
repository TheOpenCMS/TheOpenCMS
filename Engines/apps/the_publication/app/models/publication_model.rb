class PublicationModel
  class Base < ApplicationRecord
    self.abstract_class = true

    include ::ThePublication::PublicationScopes
    include ::ThePublication::PublicationStates
    include ::ThePublication::ContentProcessing
    include ::ThePublication::AdditionalTimestamps

    include ::SimpleSort::Base
    include ::Pagination::Base
    include ::FriendlyIdPack::Base
    include ::Notifications::LocalizedErrors

    belongs_to :user
    validates :title, :slug, presence: true

    EDITORS = %w[ ckeditor code_mirror plain ]
  end
end
