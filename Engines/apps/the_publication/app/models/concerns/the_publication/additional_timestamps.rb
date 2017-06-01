# include ::ThePublication::AdditionalTimestamps
module ThePublication
  module AdditionalTimestamps
    extend ActiveSupport::Concern

    included do
      before_save :set_published_at
    end

    def set_published_at
      return if published_at.present?
      self.published_at = Time.current if published?
    end
  end
end
