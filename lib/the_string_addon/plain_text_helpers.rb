class String
  def pretty_number
    self.reverse.scan(/\d{1,3}/).join(" ").reverse
  end

  def noendl
    self.gsub("\n", '')
  end

  def endl2br
    self.gsub("\n", "<br />")
  end
end
