module UserRoom
  module UserContentProcessing
    def content_processing_for(user)
      return unless user

      self.about = process_content(raw_about, user)
    end

    private

    def process_content(text, user)
      text.to_s.squish.strip
    end
  end
end
