### TheStringAddon

```
  txt = txt.to_s

  # Sanitize and empty lines process
  txt = sanitize_for(txt, current_user)
  txt = txt.empty_p2br

  # MarkDown + Code Hightlight
  txt = ::Markdown2Tags.process(txt)
  txt = ::ColoredCode.with_pygments(txt)

  # AutoLink
  al_helper = ::AutoLink.new
  txt = al_helper.auto_link(txt, sanitize: false, html: { target: :_blank, rel: :nofollow })

  # Protect content of external links
  txt = txt.add_nofollow_to_links if !current_user.admin?
  txt = txt.wrap_nofollow_links_with_noindex

  txt.strip
```

```

##   Hello World
###  Hello World
#### Hello World

*ITALIC*

**BOLD**

~~DELETED~~

_UNDERLINE_

==highlighted==

2<sup>(nd)<sup>

[Текст ссылки](адрес://ссылки.здесь "Заголовок ссылки")

foo_bar_baz

```python
# more python code
```

```