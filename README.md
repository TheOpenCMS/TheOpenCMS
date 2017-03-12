## Pagination

This simple gem provides the only method `pagination`, which takes `per_page` and `page` parameters from `params` hash and applies these parameters to a Model. In fact this gem just provides a simple helper to improve a typical staff with `per_page` and `page` parameters. Works with `Kaminary`.

```ruby
class Product < AR
  include ::Pagination::Base
end
```

```ruby
@posts = Post.pagination(params)
```

```ruby
div Items on the page:
- %w[ 5 10 20 50 100 125 ].each do |num|
  span= link_to num, url_for(per_page: num)
```

### Configurations of `page_method_name`

**config/initializers/kaminari.rb**

```ruby
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end

module ::Pagination::Base
  def self.per_method
    @per = :per_page_kaminari
  end
end
```

## Pagination (RU)

Этот простой гем всего лишь предоставляет метод `pagination`, который берет параметры `per_page` и  `page` из хеша `params` и применяет их к Модели. По факту гем просто обеспечивает простой хелпер, что бы улучшить типичную работу с переменными `per_page` и `page`. Работает с `Kaminary`.

```ruby
class Product < AR
  include ::Pagination::Base
end
```

```ruby
@posts = Post.pagination(params)
```

```ruby
div Элементов на странице:
- %w[ 5 10 20 50 100 125 ].each do |num|
  span= link_to num, url_for(per_page: num)
```

### Конфигурация параметра `page_method_name`

**config/initializers/kaminari.rb**

```ruby
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end

module ::Pagination::Base
  def self.per_method
    @per = :per_page_kaminari
  end
end
```

### MIT License

Copyright (c) 2014-[Current Year] Ilya N. Zykin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
