module ContentForProcessing
  def self.process(txt)
    reg_opts = Regexp::IGNORECASE | Regexp::MULTILINE | Regexp::EXTENDED
    no_process_reg = Regexp.new "(<noprocessing>.*?<\/noprocessing>)", reg_opts

    matches     = txt.scan no_process_reg
    split_items = matches.flatten.uniq.map{ |str| Regexp.new Regexp.escape(str) }.join('|')

    return yield(txt) if split_items.blank?

    splitted = txt.split Regexp.new("(#{ split_items })", reg_opts)

    splitted.map do |txt_part|
      txt_part.scan(no_process_reg).blank? ? \
      yield(txt_part)                      : \
      txt_part
    end.join ''
  end
end