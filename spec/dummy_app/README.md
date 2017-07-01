### Test App

```ruby
git clone git@github.com:the-teacher/to_slug_param.git

cd to_slug_param/spec/dummy_app/

bundle

RAILS_ENV=test rake db:create
RAILS_ENV=test rake db:migrate

rspec spec/helpers/string.rb
```
