```ruby
This gem is a part of TheOpenCMS project. https://github.com/TheOpenCMS
```

# ThePublication

This gem provides Publishing-oriented functionality for TheOpenCMS

### Publication Model Generator

```sh
rails generate publication_model Article
```

```ruby
app/models/article.rb
app/controllers/articles_controller.rb
db/migrate/20170528215144_create_articles_publication_model.rb
```

### Routing

*config/routes.rb*

```ruby
::ThePublication::Routes.mixin(self, :article)
```

### JS/CSS/Templates to be implemented

```slim
  = render template: 'app_theme/layouts/items/header'
  = render template: 'app_theme/layouts/items/footer'
```

*layout.css*

```css
/*
  //= require app_theme/shared/layout
*/
```

*base.coffee*

```js
#= require app_base/frontend/select_locale
```

### MIT License

Copyright (c) 2014-[Current Year] Ilya N. Zykin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
