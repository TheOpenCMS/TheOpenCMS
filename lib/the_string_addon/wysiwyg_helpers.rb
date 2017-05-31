class String
  # <p style="text-align: justify;"></p>         #=> <br>
  # <p style="text-align: justify;">   <br> </p> #=> <br>

  def empty_p2br
    txt = self.dup

    %w[ p div ].each do |tag_name|
      txt.scan(/(<#{ tag_name }.*?>)(.*?)(<\/#{ tag_name }>)/mix).each do |item|
        start   = item[0]
        content = item[1]
        fin     = item[2]

        if content.match(/\A[[:space:]]*\Z/mix)
          pattern = item.join ''
          txt = txt.gsub pattern, '<br>'
        end

        if content.match(/\A[[:space:]]*<br>[[:space:]]*\Z/mix)
          pattern = item.join ''
          txt = txt.gsub pattern, '<br>'
        end
      end
    end

    txt
  end
end
