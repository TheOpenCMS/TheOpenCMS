require_relative './env.rb'

str = <<-TXT_STRING
##   Hello World
###  Hello World
#### Hello World

http://open-cook.ru

*ITALIC*

**BOLD**

~~DELETED~~

_UNDERLINE_

==highlighted==

2<sup>(nd)<sup>

foo_bar_baz

```python
# more python code
```

[LINK TEXT](http://site.com)

![IMG ALT](http://site.com/img.png "Img title")

![](http://site.com/img.png "Img title")

> _blockquote_ text
> blockquote **text**
> blockquote text

`some code`

* элемент маркированного списка
* элемент маркированного списка
* элемент маркированного списка

0. элемент маркированного списка
0. элемент маркированного списка
0. элемент маркированного списка

Hello World

0. элемент маркированного списка
  + элемент маркированного списка
  + элемент маркированного списка
  + элемент маркированного списка
0. элемент маркированного списка
0. элемент маркированного списка

What do you want?

TXT_STRING

html = ::Markdown2Tags.process(str)
puts ::ColoredCode.with_pygments(html)