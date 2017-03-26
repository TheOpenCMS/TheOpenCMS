```ruby
This gem is a part of TheOpenCMS project. https://github.com/TheOpenCMS
```

## UserRoom

This gem provides sign-in/log-in functionality and basic user profile management interface. Based on Devise gem.

### Installation

**Install required gems**

```ruby
gem "devise"
gem "config"
gem "user_room"
```

**Ensure you have users table**

```ruby
class AddUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users
  end
end
```

**Run required genetators**

```ruby
rails generate config:install
rails generate devise:install

rails generate devise user
rake user_room_engine:install:migrations
```

The following options in the Devise migration must be turned-on

```ruby
+ Database authenticatable
+ Recoverable
+ Rememberable
+ Trackable
+ Confirmable
+ Reconfirmable
```

**Configurate Devise**

Use `gem 'config'` to configure Devise

```yml
devise:
  mailer_sender: 'mail-sender@example.com'
  parent_mailer: 'ActionMailer::Base'
  mailer: 'DeviseMailer'
```

**Add routing to your App**

```ruby
Rails.application.routes.draw do
  ::UserRoom::Routes.mixin(self)
end
```

**Include `UserRoom` concern in your Model**

```ruby
class User < ApplicationRecord
  include ::UserRoom::User
end
```

**Include `UserRoom` in `application_controller.rb`**

```ruby
class ApplicationController < ActionController::Base
  include ::UserRoom::ApplicationController
end
```

**Include `UserRoom` in `users_controller.rb`**

```ruby
class UsersController < ApplicationController
  include ::UserRoom::UsersController

  skip_before_action :user_require,   only: [ ... ]
  skip_before_action :owner_required, only: [ ... ]
  skip_before_action :admin_require,  only: [ ... ]
end
```

```ruby
rake db:migrate
```

### MIT License

Copyright (c) 2014-[Current Year] Ilya N. Zykin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
