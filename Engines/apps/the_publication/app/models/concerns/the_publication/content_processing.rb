# include ::ThePublication::ContentProcessing
module ThePublication
  module ContentProcessing
    # extend ActiveSupport::Concern

    def content_processing_for(user)
      return nil unless user

      self.title   = title.squish.strip
      self.intro   = process_content(raw_intro,   user)
      self.content = process_content(raw_content, user)
    end

    private

    def process_content(text, user)
      text = text.to_s

      case editor_type
        when 'ckeditor'
          ckeditor_process_content(text, user)
        when 'code_mirror'
          code_mirror_process_content(text, user)
        when 'plain'
          plain_process_content(text, user)
        else
          ''
      end
    end

    # Processing Helpers

    def ckeditor_process_content(text, user)
      #####################################################
      # Blocks in <noprocessing> tag will be Ignored
      #####################################################

      al_helper = ::AutoLink.new

      text = ::ContentForProcessing.process(text) do |str|
        res = str.empty_p2br

        # AutoLink + Ext Link protection
        res = al_helper.auto_link(res, sanitize: false, html: { target: :_blank, rel: :nofollow })
        res = res.add_nofollow_to_links if !user.admin?
        res = res.wrap_nofollow_links_with_noindex

        # Sanitize and Empty lines process
        res = sanitize_for(res, user)
      end

      text.strip
    end

    def code_mirror_process_content(text, user)
      text = ::ColoredCode.with_pygments(text)

      al_helper = ::AutoLink.new

      text = ::ContentForProcessing.process(text) do |str|
        # Markdown
        res = ::Markdown2Tags.process(str)
        res = res.empty_p2br

        # AutoLink + Ext Link protection
        res = al_helper.auto_link(res, sanitize: false, html: { target: :_blank, rel: :nofollow })
        res = res.add_nofollow_to_links if !user.admin?
        res = res.wrap_nofollow_links_with_noindex

        # Sanitize and Empty lines process
        res = sanitize_for(res, user)
      end

      text.strip
    end

    def plain_process_content(text, user)
      sanitize_for(text, user).strip
    end

    def sanitize_for(text, user)
      if user.admin?
        ::Sanitize.fragment(text, Sanitize::Config::ADMIN_RELAXED)
      else
        ::Sanitize.fragment(text, Sanitize::Config::BLOGGER_HTML)
      end
    end

  end # ContentProcessing
end # ThePublication
