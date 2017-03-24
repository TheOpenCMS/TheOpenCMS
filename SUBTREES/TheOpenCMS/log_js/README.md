```ruby
This gem is a part of TheOpenCMS project. https://github.com/TheOpenCMS
```

# LogJS

Take care of your joints. Replace `console.log` with `log` in your Rails App

## Installation

**Gemfile**

```ruby
gem 'log_js'
```

## Usage

**application.js**

```coffeescript
//= require jquery
//= require log_js
```

Nobody wants to see `log` messages in a web console in the production mode.
You can configure a visibility of `log` messages with `data-log-js` param.

**layouts/application.html.slim**

```slim
head class=('log-js' if Rails.env.development?)
```

**Into your Browser Console**

```javascript
log('Hello World!')
```

**Turn On/Off**

```javascript
LogJS.enable = true  // log messages will be visible
LogJS.enable = false // log messages will be disabled
```

turn on via URL address

```
https://example.com/products?uid=12345&log-js
```

### MIT License

Copyright (c) 2014-[Current Year] Ilya N. Zykin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
