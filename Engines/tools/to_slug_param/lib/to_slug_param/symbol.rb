class Symbol
  def to_slug_param opts = {}
    String.to_slug_param(self.to_s, opts)
  end

  def to_slug_param_base opts = {}
    String.to_slug_param_base(self.to_s, opts)
  end

  def slugged_filename opts = {}
    String.slugged_filename(self.to_s, opts)
  end

  def slugged_filepath opts = {}
    String.slugged_file(self.to_s, opts)
  end
end
