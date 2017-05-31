module TheStringAddon
  # [start of string] (any chars) @ (any chars) . (any chars)[2-15] [end of string]
  EMAIL_REGEXP = /\A(\S+)@(\S+)\.(\S{2,15})\z/

  def self.normalize_email str
    str.to_s.squish.strip.gsub(/\s*/, '')[0..300]
  end

  # TheStringAddon.to_email(str) => email | nil
  def self.to_email str
    _email = ::TheStringAddon.normalize_email(str)
    _email.match(::TheStringAddon::EMAIL_REGEXP) ? _email : nil
  end
end
