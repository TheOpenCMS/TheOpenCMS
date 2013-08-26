### TheStringToSlug

Convert text string to slug param

Translite, downcase, parameterize

#### Install

```ruby
gem "the_string_to_slug", "~> 0.0.5"
```

<a href="http://rubygems.org/gems/the_string_to_slug">RubyGems/the_string_to_slug</a>

#### Using

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

For filenames:

```ruby
"/доки/dir/тест/документ.doc".slugged_filename         #=> "dokument.doc"
String.slugged_filename("/доки/dir/тест/документ.doc") #=> "dokument.doc"
```

For full file path:

```ruby
"/доки/dir/тест/документ.doc".slugged_file             #=> "/доки/dir/тест/dokument.doc"
String.slugged_filename("/доки/dir/тест/документ.doc") #=> "/доки/dir/тест/dokument.doc"
```