```ruby
This gem is a part of TheOpenCMS project. https://github.com/TheOpenCMS
```

## Voiceless

This simple gem helps to keep system work if some part of the system is not included.

For example, sometimes a common engine for a multiple projects may has an ECommerce module and sometimes doesn't. Common code base must be stable even the system can't provide some functionality in routes, controllers or models.

This gem wrap potentially dangerous code with a block, where we catch an exception and show to a developer just a notification message where we don't have some part of a code.

In fact `voiceless` method is just a method like method `try`, but for `include` directives.

## How it works

There is the only method `voiceless`, and it works so:

```ruby
class ApplicationController < ActionController::Base
  voiceless { include ::TheOpenShop::Base }
end

class Article < ApplicationRecord
  voiceless { include ::SimpleSort::Model }

  private

  def send_notifications
    voiceless { NotificationMailer.deliver }
  end
end

Rails.application.routes.draw do
  voiceless { include ::UserRoom::Routes }
end
```

In case of a problem `voiceless` shows a warning and code still works

```ruby
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
VOICELESS ALERT: uninitialized constant UserRoom::Routes
/config/routes.rb:14
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
```

## How to install

```ruby
gem 'voiceless', github: 'TheOpenCMS/voiceless'
```

======

## Voiceless (RU)

Этот простой гем помогает поддерживать систему работоспособной даже если какая-то часть системы не подключена.

Например, иногда общий движок для нескольких проектов может иметь модуль Электронной коммерции, а иногда нет. Общий код должен быть стабилен даже если система не может обеспечить некоторую функциональность в роутинге, контроллерах и моделях.

### Как это работает

По факту метод `voiceless` это метод похожий на метод `try`, но для `include` директив.

```ruby
class ApplicationController < ActionController::Base
 voiceless { include ::TheOpenShop::Base }
end

class Article < ApplicationRecord
  voiceless { include ::SimpleSort::Model }

  private

  def send_notifications
    voiceless { NotificationMailer.deliver }
  end
end

Rails.application.routes.draw do
 voiceless { include ::UserRoom::Routes }
end
```

В случае проблем `voiceless` показывает предупреждение, а код продолжает работать

```ruby
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
VOICELESS ALERT: uninitialized constant UserRoom::Routes
/config/routes.rb:14
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
```
## Как установить

```
gem 'voiceless', github: 'TheOpenCMS/voiceless'
```

## The MIT License

https://opensource.org/licenses/MIT

The MIT License (MIT)

Copyright (c) 2016-[Current Year] Ilya N. Zykin (https://github.com/the-teacher)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
