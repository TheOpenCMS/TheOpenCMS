## JS code style

TheOpenCMS uses [Coffee Script](http://coffeescript.org/) for JS code.

You can use [YARN](https://yarnpkg.com/en/) as a dependency management tool for JS.

You should use [JQuery 3](http://jquery.com/) and packages from JQuery eco-system to write new Client-Side functionality for TheOpenCMS.

You shouldn't use WebPack and React, Vue, Ember, Angular and other tools like these, before the first stable release of TheOpenCMS, because it's difficult to predict a complexity of using these tools in case of this project.

### Pattern Module

[Pattern Module](https://github.com/addyosmani/essential-js-design-patterns) is a preferred pattern for this project. Try to use this pattern as much as it possible.

* Each module has to have `init` method to perform initialization later
* Each module has to be added to a global scope via `@` to be visible in a browser's console anytime.
* All modules must be initialized at the only place via JQuery `on DOM ready` event `$ ->`.

There is an example how it can look with coffee script

```coffee
@SearchLine = do ->
  init: ->
    doc = $(document)

    doc.on 'focus', '.js-search_line-input', (e) ->
      input = $(e.currentTarget)
      input.addClass 'search_line-input_focused'

      doc.on 'blur', '.js-search_line-input', (e) ->
        input = $(e.currentTarget)
        input.removeClass 'search_line-input_focused'
```

Later you should `init` modules like that:

```coffee
$ ->
  do SearchLine.init
  do Subscriptions.init
  do AjaxPagination.init
```
