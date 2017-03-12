# Content is Everything!

Let's make Content Management Systems great again! Together we can!

## TheOpenCMS

CMS (Content Management System) based on Rails.

### Features

This open CMS provides:

* User Room
  * Authentication via Devise
  * Sign in/Login via social networks: Facebook, Twitter, G+, Vk.com ...
  * User's cabinet. Basic management panel to manage a user's profile
* Blogging System
  * Articles, News, Recipes etc.
  * SEO friendly markup
  * Powerful commenting system

## Docs

See documentation in [DOCS](./docs)

## Changelog

See documentation in [Changelog](./docs/Changelog.md)

## Contribution notes

This project uses `git subtree` approach. You will find many of dependencies in the folder [SUBTREES](./SUBTREES)

You can change files of the main project and also all dependencies right in the current `master` and push them all together to the main repo of the project. All changes will be stored in the main repo.

If you want to update a specific repo of a dependency then you can do that directly via command `git subtree push`. Also you can use this simple automatic [ruby script](./SUBTREES/subtree.rb) to updated a few dependencies in the same time.

Examples:

```ruby
ruby SUBTREES/subtree.rb add the_open_cms

ruby SUBTREES/subtree.rb pull the_open_cms

ruby SUBTREES/subtree.rb push the_open_cms
```

### The MIT License (MIT)

Copyright (c) 2017-[Current Year] Ilya N. Zykin (https://github.com/the-teacher)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
