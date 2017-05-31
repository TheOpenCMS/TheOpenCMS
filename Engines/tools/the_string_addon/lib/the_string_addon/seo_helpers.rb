class String
  def seo_compact
    self.squish.strip.gsub(/\s*,\s*/, ',')
  end

  def add_nofollow_to_links
    src_content = self.dup
    content     = src_content.dup

    content.scan /(<a.*?>)(.*?)(<\/a>)/mix do |link_parts|
      tag_start   = link_parts[0]
      tag_content = link_parts[1]
      tag_end     = link_parts[2]

      unless tag_start_parts = tag_start.match(/(rel=#{ ANY_QUOTE })(#{ ANY_CONTENT })(#{ ANY_QUOTE })/mix)
        unless tag_start.match(/#{ String.trusted_sites.join('|') }/mix)
          old_link = link_parts.join('')
          new_link = ["<a rel='nofollow' #{ tag_start[3..-1] }", tag_content, tag_end].join('')

          src_content.gsub! old_link, new_link
        end
      end
    end

    src_content
  end

  def wrap_nofollow_links_with_noindex
    src_content = self.dup
    content     = src_content.dup

    # find links which wrapped with noindex
    noindexed_links = []
    content.scan /<noindex>(#{ CAN_HAS_SPACE })(<a#{ ANY_CONTENT }>)(#{ ANY_CONTENT })(<\/a>)(#{ CAN_HAS_SPACE })<\/noindex>/mix do |item|
      noindexed_links << item[1..3].join('')
    end

    # all links
    all_links = []
    content.scan /(<a#{ ANY_CONTENT }>)(#{ ANY_CONTENT })(<\/a>)/mix do |item|
      link = item.join

      if link.match(/(rel=#{ ANY_QUOTE })(#{ ANY_CONTENT })(#{ ANY_QUOTE })/mix)
        if link.match /nofollow/mix
          all_links << item.join
        end
      end
    end

    # if link not in list of wrapped links - wrap it
    # identical links will gives wrong result. So, let it be
    all_links.each do |link|
      unless noindexed_links.include?(link)
        src_content.gsub! link, "<noindex>#{ link }</noindex>"
      end
    end

    src_content
  end
end
