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

  def slugged_filename
    self.class.slugged_filename(self)
  end

  # -----------------------------------
  # Slugged FileName
  # -----------------------------------
  def self.file_ext file_name
    File.extname(file_name)[1..-1].to_s.to_slug_param
  end

  def self.file_name file_name
    file_name = File.basename(file_name)
    ext       = File.extname(file_name)
    File.basename(file_name, ext).to_s.to_slug_param
  end

  def self.slugged_filename file_name
    file_name = File.basename(file_name)
    fname     = self.file_name(file_name)
    ext       = self.file_ext(file_name)

    return fname if ext.blank?
    [fname, ext].join('.')
  end
end