require "rails-i18n"
require "the_string_to_slug/version"

module TheStringToSlug; end

class String
  def self.to_slug_param str
    I18n::transliterate(str).gsub('_','-').parameterize('-').downcase
  end

  def to_slug_param
    self.class.to_slug_param(self)
  end
end