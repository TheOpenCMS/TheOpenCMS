## Subtrees

This project uses `git subtree` approach. You will find many of dependencies in the folder [SUBTREES](./SUBTREES)

You can change files of the main project and also all dependencies right in the current `master` and push them all together to the main repo of the project. All changes will be stored in the main repo.

If you want to update a specific repo of a dependency then you can do that directly via command `git subtree push`. Also you can use this simple automatic [ruby script](./SUBTREES/subtree.rb) to updated a few dependencies in the same time.

Examples:

```ruby
ruby SUBTREES/subtree.rb add the_open_cms

ruby SUBTREES/subtree.rb pull the_open_cms

ruby SUBTREES/subtree.rb push the_open_cms
```

### Common syntax

To add subtree

```
git subtree add
  --prefix PATH_TO_DIR \
  GIT_REMOTE_SOURCE \
  BRANCH --squash
```

For example

```
git subtree add \
  --prefix SUBTREES/TheOpenCMS/voiceless \
  git@github.com:TheOpenCMS/voiceless.git \
  master --squash
```

Push changes to a repo

```
git subtree push \
  --prefix SUBTREES/TheOpenCMS/voiceless \
  git@github.com:TheOpenCMS/voiceless.git \
  master --squash
```

Pull changes

```
git subtree pull \
  --prefix SUBTREES/TheOpenCMS/voiceless \
  git@github.com:TheOpenCMS/voiceless.git \
  master
```
