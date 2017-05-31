require_relative './env.rb'

str = %{
<pre>```ruby
module JsvoidHelper
&nbsp; def jsvoid
&nbsp;&nbsp;&nbsp; 'javascript:void(0)'
&nbsp; end
end
```
</pre><p>Мы рады сообщить, что магазин <a rel="nofollow" href="http://stereo-shop.ru">stereo-shop.ru</a> стал партнером <a rel="nofollow" href="https://market.yandex.ru/">Яндекс.Маркета</a>. Теперь наши товары легко найти и убедиться в привлекательности наших цен.</p><pre>```ruby
# ::ColoredCode.pygments_langs
# ::ColoredCode.with_pygments_css(:monokai)
# txt = ::ColoredCode.with_pygments(txt)

class ColoredCode
  class &lt;&lt; self

    def pygments
      ::Pygments
    end

    def pygments_langs
      @@pygments_lexers ||= get_pygments_langs
    end

    def get_pygments_langs
      pygments_lexers = []

      pygments.lexers.sort{|a,b| a.first &lt;=&gt; b.first }.each_with_index do |lexer, index|
        pygments_lexers &lt;&lt; lexer.last[:aliases]
      end

      pygments_lexers.flatten.map(&amp;:downcase)
    end

    def with_pygments_css theme = :monokai
      pygments.css(style: theme)
    end

    def with_pygments txt
      txt.gsub(/```(.*?)$(.*?)```/mix) do
        original_match = Regexp.last_match[0]

        lang = $1.downcase
        code = $2

        if pygments_langs.include?(lang)
          pygments.highlight(code, lexer: lang, options: { encoding: 'utf-8', linenos: true })
        else
          original_match
        end
      end
    end

  end # class &lt;&lt; self
end
```
</pre><p> </p><p><img title="Магазин Stereo-Shop - партнер Яндекс.Маркета" style="width: 610px; height: 200px;" alt="Магазин Stereo-Shop - партнер Яндекс.Маркета" src="http://ocshop.info/wp-content/uploads/2015/06/1_yandex_market_1.png" /></p><p>Поскольку на Маркете Stereo-Shop появился совсем недавно, у нас еще мало отзывов и низкий рейтинг. Будем благодарны, если Вы оставите отзыв о магазине на Яндекс.Маркете!</p>

```html

<table border="1">
    <caption>Таблица размеров обуви</caption>
    <tr>
        <th>Россия</th>
        <th>Великобритания</th>
        <th>Европа</th>
        <th>Длина ступни, см</th>
    </tr>
    <tr>
        <td>34,5</td>
        <td>3,5</td>
        <td>36</td>
        <td>23</td>
    </tr>
    <tr>
        <td>35,5</td>
        <td>4</td>
        <td>36⅔</td>
        <td>23–23,5</td>
    </tr>
    <tr>
        <td>36</td>
        <td>4,5</td>
        <td>37⅓</td>
        <td>23,5</td>
    </tr>
    <tr>
        <td>36,5</td>
        <td>5</td>
        <td>38</td>
        <td>24</td>
    </tr>
    <tr>
        <td>37</td>
        <td>5,5</td>
        <td>38⅔</td>
        <td>24,5</td>
    </tr>
    <tr>
        <td>38</td>
        <td>6</td>
        <td>39⅓</td>
        <td>25</td>
    </tr>
    <tr>
        <td>38,5</td>
        <td>6,5</td>
        <td>40</td>
        <td>25,5</td>
    </tr>
    <tr>
        <td>39</td>
        <td>7</td>
        <td>40⅔</td>
        <td>25,5–26</td>
    </tr>
    <tr>
        <td>40</td>
        <td>7,5</td>
        <td>41⅓</td>
        <td>26</td>
    </tr>
    <tr>
        <td>40,5</td>
        <td>8</td>
        <td>42</td>
        <td>26,5</td>
    </tr>
    <tr>
        <td>41</td>
        <td>8,5</td>
        <td>42⅔</td>
        <td>27</td>
    </tr>
    <tr>
        <td>42</td>
        <td>9</td>
        <td>43⅓</td>
        <td>27,5</td>
    </tr>
    <tr>
        <td>43</td>
        <td>9,5</td>
        <td>44</td>
        <td>28</td>
    </tr>
    <tr>
        <td>43,5</td>
        <td>10</td>
        <td>44⅔</td>
        <td>28–28,5</td>
    </tr>
    <tr>
        <td>44</td>
        <td>10,5</td>
        <td>45⅓</td>
        <td>28,5–29</td>
    </tr>
    <tr>
        <td>44,5</td>
        <td>11</td>
        <td>46</td>
        <td>29</td>
    </tr>
    <tr>
        <td>45</td>
        <td>11,5</td>
        <td>46⅔</td>
        <td>29,5</td>
    </tr>
    <tr>
        <td>46</td>
        <td>12</td>
        <td>47⅓</td>
        <td>30</td>
    </tr>
    <tr>
        <td>46,5</td>
        <td>12,5</td>
        <td>48</td>
        <td>30,5</td>
    </tr>
    <tr>
        <td>47</td>
        <td>13</td>
        <td>48⅔</td>
        <td>31</td>
    </tr>
    <tr>
        <td>48</td>
        <td>13,5</td>
        <td>49⅓</td>
        <td>31,5</td>
    </tr>
</table>
```
}


# Regexp.last_match
# ::ColoredCode.pygments_langs

str = ::ColoredCode.with_pygments(str)
puts str
