### Test App

```ruby
git clone git@github.com:the-teacher/the_string_to_slug.git

cd the_string_to_slug/spec/dummy_app/

bundle

RAILS_ENV=test rake db:create
RAILS_ENV=test rake db:migrate

rspec spec/helpers/string.rb
```