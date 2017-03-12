# TheOpenCMS weekly report

### Week 1

Hello World! Content is Everything!

This week I've decided to create a new CMS on Rails 5. Actually I already have some code drafts and ideas about how my CMS has to work, and I think this time I'll reach my goal.

First of all I had to decide how I would split my CMS into the parts and how I would manage all this staff.

I choose `git subtrees` to manage dependencies in my project. With subtrees I can keep all the code in a one place and I will manage the only one repo, however I can update each dependance separately. I was confused with `--squash` option on the `git subtree pull` command. I don't like how this option works. And that's why I will not use it.

I've created a small ruby script to work with subtree commands. During the development process I do something like this:

```ruby
ruby SUBTREES/subtree.rb add  the_open_cms

ruby SUBTREES/subtree.rb pull the_open_cms

ruby SUBTREES/subtree.rb push the_open_cms
```

With these commands I can `add`, `pull`, `push` all dependencies at the same time. Right now it works fine for me.

#### Gems were published

This week I've already published a few small but helpful gems. They will be used when I'll be implementing User's cabinet. There is the list of these gems:

* `voiceless` very small [gem](https://github.com/TheOpenCMS/voiceless) helps split system in to the parts.
* `log_js` very small [gem](https://github.com/TheOpenCMS/log_js) provides a shortcut method `log` for method `console.log`.
* `pagination` very small [gem](https://github.com/TheOpenCMS/pagination) provides a helper for Kaminari pagination.
* `simple_sort` small [gem](https://github.com/TheOpenCMS/simple_sort) provides a few sort helpers for AR models.
* `image_tools` small [gem](https://github.com/TheOpenCMS/image_tools) provides a few helpers for image manipulations.
* `crop_tool` small [gem](https://github.com/TheOpenCMS/crop_tool) provides a crop tool for Images.
* `notifications` small [gem](https://github.com/TheOpenCMS/notifications) provides a helper to show flash notifications in a Rails app.

#### Goals

My first goal is to create a user's cabinet (user registration & user profile). On the first step I will implement signing by email and most popular social networks. Also I have to implement avatars' uploading and maybe some email notifications. Not sure right now. We will see.

#### Current status

The app still doesn't work. There are a lot of things to do, but I know what I have to finish to make it alive. Wish me good luck :)

TheOpenCMS. Content is Everything!
See you next week!
