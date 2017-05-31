module UserRoom
  module UserContentProcessing
    def content_processing!(user = self)
      self.login = login.to_s.to_slug_param
      self.about = process_content(raw_about, user)
    end

    private

    def process_content(text, user)
      text.to_s.squish.strip
    end
  end
end
