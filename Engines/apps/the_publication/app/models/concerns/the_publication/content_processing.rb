# include ::ThePublication::ContentProcessing
module ThePublication
  module ContentProcessing
    # extend ActiveSupport::Concern

    def content_processing_for(current_user)
      return nil unless current_user

      self.title   = title.squish.strip
      self.intro   = process_content(raw_intro,   current_user)
      self.content = process_content(raw_content, current_user)
    end

    private

    def process_content(txt, current_user)
      txt = txt.to_s

      # Code Hightlight
      txt = ::ColoredCode.with_pygments(txt)

      #####################################################
      # Blocks in <noprocessing> tag will be Ignored
      #####################################################

      al_helper = ::AutoLink.new

      txt = ::ContentForProcessing.process(txt) do |str|
        # Markdown
        res = ::Markdown2Tags.process(str)
        res = res.empty_p2br

        # AutoLink + Ext Link protection
        res = al_helper.auto_link(res, sanitize: false, html: { target: :_blank, rel: :nofollow })
        res = res.add_nofollow_to_links if !current_user.admin?
        res = res.wrap_nofollow_links_with_noindex

        # Sanitize and Empty lines process
        res = sanitize_for(res, current_user)
      end

      txt.strip
    end # process_content

    def sanitize_for(txt, current_user)
      if current_user.admin?
        Sanitize.fragment(txt, Sanitize::Config::ADMIN_RELAXED)
      else
        Sanitize.fragment(txt, Sanitize::Config::BLOGGER_HTML)
      end
    end # sanitize_for

  end
end
