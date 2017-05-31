```ruby
This gem is a part of TheOpenCMS project. https://github.com/TheOpenCMS
```

## Notifications

Just add JSON on HTML notifications in your Rails app

```ruby
gem 'notifications'
```

## How it works

This gem helps you to get rid of this bunch of a code

```ruby
<%= form_for(@resource) do |f| %>
  <% if @resource.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@resource.errors.count, "error") %> prohibited this resource from being saved:</h2>

      <ul>
      <% @resource.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  # ....

<% end %>
```

and replace it with the following code:

```slim
  - form_for(@post) do |f|
    = render partial: 'notifications/form', locals: { object: @post }
```

and this code to render Flash messages:

```slim
body
  = render partial: 'notifications/flash'
  = yield
```

## How to use

*Note:* `toastr` is an external dependency for `format: :json` case. Download and and install it yourself. `vendors/toastr` is just a demo path to assets

*application.css*

```css
/*
  //= require notifications/base
*/
```

*application.js*

```js
//= require notifications/base
```

*application_initializer.js*

```coffee
$ ->
  do Notifications.init
```

### Format `html` or `json`

You can select a way how to render notifications. There are 2 options: `format: :html` and `format: :json`

```slim
= render partial: 'notifications/flash', locals: { format: :html }
= render partial: 'notifications/form', locals: { object: @post, format: :json }
```

### Default notifications format

*initializers/notifications.rb*

```ruby
Notifications.configure do |config|
  config.default_type = :json # :html
end
```

### Errors' localization

To avoid this case

```
Title: не может быть пустым
```

Do the following steps:

*models/user.rb*

```ruby
class Post < ActiveRecord::Base
  include ::Notifications::LocalizedErrors
end
```

*config/locales/ru.yml*

```yml
activerecord:
  models:
    post: Публикация
  attributes:
    post:
      title: "Загловок"
```

Now errors messages will look so:

```
Загловок: не может быть пустым
```

### MIT License

Copyright (c) 2013-[Current Year] Ilya N. Zykin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
