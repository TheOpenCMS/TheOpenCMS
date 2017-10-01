```ruby
This gem is a part of TheOpenCMS project. https://github.com/TheOpenCMS
```

# SimpleSort

Gem provides simple sort on Active Record collections.

# How it works

Add `SimpleSort` functionality to your Model

```ruby
class Product  < ApplicationRecord
  include ::SimpleSort::Base
end
```

Use method `simple_sort` with your Model in a controller like this:

```ruby
class ProductsController < ApplicationController
  def index
    @products = Product.simple_sort(params)
  end
end
```

* Use `simple_sort_url` helper in your views to provide sorting for required field
* Use `reset_simple_sort` helper to reset current sort params

```ruby
= link_to 'Reset sort params', url_for(reset_simple_sort)

= link_to 'Title ↕',      simple_sort_url(:title)
= link_to 'Created At ↕', simple_sort_url(:crated_at)
= link_to 'Updated At ↕', simple_sort_url(:updated_at)
```

# Bonus methods for Models

Also gem provides some dead-simple but helpful methods

* `max2min` for descending order `DESC` (1000, 102, 15, 3)
* `min2max` for ascending order `ASC` (3, 15, 102, 1000)
* `random` random record from a database (`mysql`, `psql`)

```ruby
class ProductsController < ApplicationController
  def index
    @products = Product.max2min(:created_at)
    @articles = Article.min2max(:title)
    @banners  = Banner.random.limit(3)
  end
end
```

### How to test

```
git clone https://github.com/TheOpenCMS/simple_sort.git

cd simple_sort/tests/dummy_app/
bundle

RAILS_ENV=test bundle exec rake db:setup

bundle exec rspec
```

### MIT License

Copyright (c) 2014-[Current Year] Ilya N. Zykin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
