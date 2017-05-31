# ::ColoredCode.pygments_langs
# ::ColoredCode.with_pygments_css(:monokai)
# txt = ::ColoredCode.with_pygments(txt)

class ColoredCode
  class << self

    def pygments
      ::Pygments
    end

    def pygments_langs
      @@pygments_lexers ||= get_pygments_langs
    end

    def pygments_langs_regexp
      Regexp.new @@pygments_lexers.join('|')
    end

    def get_pygments_langs
      pygments_lexers = []

      pygments.lexers.sort{|a,b| a.first <=> b.first }.each_with_index do |lexer, index|
        pygments_lexers << lexer.last[:aliases]
      end

      pygments_lexers.flatten.map(&:downcase)
    end

    def with_pygments_css theme = :monokai
      pygments.css('.highlight', style: theme)
    end

    def with_pygments txt
      supported_langs = Regexp.new pygments_langs.join('|')

      txt.gsub(/```(#{ pygments_langs_regexp })\s*\n(.*?)\n```/mix) do
        original_match = Regexp.last_match[0]

        lang = $1.downcase
        code = $2

        if pygments_langs.include?(lang)
          # for console: debug => formatter: :terminal
          "<noprocessing>" + pygments.highlight(code, lexer: lang, options: { encoding: 'utf-8', linenos: true }) + "</noprocessing>"
        else
          original_match
        end
      end
    end

  end # class << self
end