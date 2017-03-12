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
head(data-log-js=Rails.env.development?)
```

**Into your Browser Console**

```javascript
log('Hello World!')
```

```javascript
LogJS.enable = true  // log messages will be visible
LogJS.enable = false // log messages will be disabled
```
