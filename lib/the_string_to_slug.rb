require "rails-i18n"
require "the_string_to_slug/version"

module TheStringToSlug; end

class String
  def to_slug_param
    self.class.to_slug_param(self)
  end

  def slugged_filename
    self.class.slugged_filename(self)
  end

  def slugged_file
    self.class.slugged_file(self)
  end

  # -----------------------------------
  # Self methods
  # -----------------------------------
  class << self
    def to_slug_param str
      I18n::transliterate(str).gsub('_','-').parameterize('-').downcase
    end

    def file_ext file_name
      File.extname(file_name)[1..-1].to_s.to_slug_param
    end

    def file_name file_name
      file_name = File.basename(file_name)
      ext       = File.extname(file_name)
      File.basename(file_name, ext).to_s.to_slug_param
    end

    def slugged_filename file_name
      file_name = File.basename(file_name)
      fname     = self.file_name(file_name)
      ext       = self.file_ext(file_name)

      return fname if ext.blank?
      [fname, ext].join('.')
    end

    def slugged_file file_full_path
      file_name = slugged_filename file_full_path
      file_full_path.split('/')[0...-1].push(file_name).join '/'
    end
  end
end