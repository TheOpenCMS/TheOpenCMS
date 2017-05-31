### TheStringToSlug

Convert strings and symbols to slug param

Transliteration + Parameterization for slugs building

#### Install

```ruby
gem "the_string_to_slug", "~> 1.2"
```

<a href="http://rubygems.org/gems/the_string_to_slug">RubyGems/the_string_to_slug</a>

#### Using

For russian transliteration by default

```ruby
I18n.enforce_available_locales = true

module DummyApp
  class Application < Rails::Application
    config.i18n.default_locale = :ru
  end
end
```

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
"/доки/dir/тест/документ.doc".slugged_filepath         #=> "/доки/dir/тест/dokument.doc"
String.slugged_filepath("/доки/dir/тест/документ.doc") #=> "/доки/dir/тест/dokument.doc"
```

Params

```ruby
"Документ.doc".to_slug_param(locale: :ru) # => "dokument-doc"
"Документ.doc".to_slug_param(locale: :en) # => "doc"
```

```ruby
"Документ.doc".to_slug_param(sep: '_', locale: :ru) # => "dokument_doc"
"Документ.doc".to_slug_param(sep: '_', locale: :en) # => "doc"
```

### MIT-LICENSE

##### Copyright (c) 2013-2014 [Ilya N.Zykin]

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
