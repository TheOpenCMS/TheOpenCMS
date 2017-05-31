require "the_string_addon/version"

require 'sanitize'
require 'pygments'
require 'redcarpet'

require 'action_view'
require 'rails_autolink'
require 'rails_autolink/helpers'

module TheStringAddon
  class Engine < Rails::Engine; end
end

class String
  ANY_QUOTE     = '[\"|\']'
  ANY_CONTENT   = '.*?'
  CAN_HAS_SPACE = '[[:space:]]*?'

  def self.trusted_sites
    %w[ site.com example.com ]
  end
end

class ActiveSupport::TimeWithZone
  def to_rus_date_1
    ::I18n.l(self, format: "%-d %B %Y %H:%M")
  end

  def to_rus_date_2
    ::I18n.l(self, format: "%H:%M %-d.%-m.%Y")
  end
end

require "the_string_addon/seo_helpers"
require "the_string_addon/email_checking"
require "the_string_addon/wysiwyg_helpers"
require "the_string_addon/plain_text_helpers"
