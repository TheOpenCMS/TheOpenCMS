class RenderWithoutCode < Redcarpet::Render::HTML
  def block_code(code, language)
    "\n```#{ language }\n#{ code }```"
  end
end

module Markdown2Tags
  def self.process txt
    options = {
      autolink: false,
      underline: true,
      highlight: true,
      superscript: false,
      strikethrough: true,

      no_intra_emphasis: true,
      space_after_headers: false,

      fenced_code_blocks: true,
      disable_indented_code_blocks: true
    }

    markdown = ::Redcarpet::Markdown.new(RenderWithoutCode, options)
    html = markdown.render(txt)
  end
end