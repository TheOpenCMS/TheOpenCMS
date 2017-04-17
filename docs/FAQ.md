[&larr; Docs](./README.md)

```
```
## Frequently Asked Question

### Structure of the Project

*Question:*

I'm an experienced Rails developer. I've checked the code of the Project and I didn't find Models, Controllers and so on. I've found just migration files and Mailer Previews. Are you joking on me? What is going on in this project? Where are Rails app files?

*Answer:*

TheOpenCMS is a typical monolith Rails App. The only difference is the project consists of a couple of separated Rails Engines. Each Engine provides a specific functionality.

The Root Rails App is almost empty, because all file are in specific Rails Engines.

All Engines are placed here. There you can find Models, Controllers, etc. All migrations from Engines must be installed via default `Rails generators` for Rails Engines. That is why all installed migrations are available in The Root Rails App.

Unfortunately `ActionMailer::Preview` doesn't provide a possibility to use Preview classes from Engines. That is why I keep `Mailer Preview` classes in the Root Rails App.

So. In the Root Rails App you will find only a small part of important files and configurations. Everything else you can find in a [folder with Engines]()

### Rails Engines

*Question:*

Why do you think using of Rails Engines is a good approach? Why do you use them?

*Answer:*

I've done already some Rails applications from the scratch, and each time I can see very similar functionality in all typical Rails apps: Login via social networks, Image Cropping, Blogging functionality, Comments, Tags etc.

In TheOpenCMS I will try to decompose functionality so, to make it possible to reuse parts of the project later.

Within this project I'll try to build a few independent Rails Engines. Each Engine provides a specific functionality.

### Git Subtrees

*Question:*

I didn't use `git subtrees` before. Why do you use it? Why don't you use `git submodules`?

*Answer:*

TheOpenCMS will be build of Rails Engines. Each engine actually must be a separated gem and it will provide a specific functionality.

Actually I have to develop and maintain a couple of gems for the Project.

If you don't have a relevant experience, you have to know, it's really difficult to manage multiple gems at the same time.

That is why usually people use `git submodules` to manage multiple gems within a project and to know a current state of each gem at any time.

Unfortunately `git submodules` is the very uncomfortable way if you work in a team with a few colleges.

I've tried another way `git subtrees`. This way looks really promising.

With `git subtrees` you can develop the only code base and update all requirements with much more comfortable way if you need. Looks like it must provide also a very comfortable way to work with pull requests in a team.
