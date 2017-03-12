# SimpleSort

Simple sort for The!ProfitCMS

```ruby
include SimpleSort::Base

= link_to 'Title↕', simple_sort_url(:title)

@products = Product.recent.simple_sort(params)

= link_to 'Reset filters', url_for( reset_simple_sort )
# params.merge(sort_type: nil, sort_column: nil)
```
