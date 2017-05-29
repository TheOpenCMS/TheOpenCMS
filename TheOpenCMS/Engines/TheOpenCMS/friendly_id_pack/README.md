# FriendlyIdPack

```ruby
class SlugIds < ActiveRecord::Migration
  def change
    [:pages, :posts].each do |table_name|
      change_table table_name do |t|
        t.string :slug,        default: ''
        t.string :short_id,    default: ''
        t.string :friendly_id, default: ''
      end
    end
  end
end
```

```ruby
class Post < ActiveRecord::Base
  include FriendlyIdPack::Base
end

post = Post.new
post.title = "Привет"
post.save


post.title        # => "Привет"
post.slug         # => "privet"
post.short_id     # => "pt1263"
post.friendly_id  # => "pt1263+privet"

Post.friendly_where(:privet) # => [post ...]
Post.friendly_first(:privet) # => post
```

### MIT

zykin-ilya@ya.ru 2014
