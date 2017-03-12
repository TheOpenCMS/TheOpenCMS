## Notifications

Just add JSON on HTML notifications in your Rails app

```ruby
gem 'notifications'
```

## How it works

This gem helps to you get rid of this bunch of a code

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
//= require vendors/toastr
```

*application.js*

```js
//= require vendors/toastr
//= require notifications

$ ->
  Notifications.init()
  Notifications.show_notifications()
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
  include Notifications::LocalizedErrors
end
```

*config/locales/ru.yml*

```
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
