require "rails-i18n"
require "the_string_to_slug/version"

module TheStringToSlug; end

class String
  def to_slug_param opts = {}
    self.class.to_slug_param(self, opts)
  end

  def slugged_filename opts = {}
    self.class.slugged_filename(self, opts)
  end

  def slugged_file opts = {}
    self.class.slugged_file(self, opts)
  end

  # -----------------------------------
  # Self methods
  # -----------------------------------
  class << self
    def to_slug_param str, opts = {}
      delimiter = opts.delete(:delimiter) || '-'

      str = I18n::transliterate(str.mb_chars, opts)
        .gsub('_', delimiter)
        .parameterize(delimiter)
        .downcase.to_s
    end

    def file_ext file_name, opts = {}
      File.extname(file_name)[1..-1].to_s.to_slug_param opts
    end

    def file_name name, opts = {}
      name = File.basename name
      ext  = File.extname  name
      File.basename(name, ext).to_s.to_slug_param opts
    end

    def slugged_filename name, opts = {}
      name  = File.basename  name
      fname = self.file_name name, opts
      ext   = self.file_ext  name, opts

      return fname if ext.blank?
      [fname, ext].join('.')
    end

    def slugged_file file_full_path, opts = {}
      fname = slugged_filename file_full_path, opts
      file_full_path.split('/')[0...-1].push(fname).join '/'
    end
  end
end