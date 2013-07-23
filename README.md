### TheStringToSlug

Convert text string to slug param

Translite, downcase, parameterize

```ruby
"Привет Мир! Hello world!".to_slug_param
# => "privet-mir-hello-world"

String.to_slug_param("Привет Мир! Hello world!")
# => "privet-mir-hello-world"
```

Be carefully with file extension

```ruby
"Документ.doc".to_slug_param
# => "dokument-doc"
```