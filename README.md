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

* Use `simple_sort_url` helper in your views to provide sorting.
* Use `reset_simple_sort` helper to reset current sort params

```ruby
= link_to 'Reset filters', url_for(reset_simple_sort)

= link_to 'Title ↕',      simple_sort_url(:title)
= link_to 'Created At ↕', simple_sort_url(:crated_at)
= link_to 'Updated At ↕', simple_sort_url(:updated_at)
```

### MIT License

Copyright (c) 2014-[Current Year] Ilya N. Zykin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
