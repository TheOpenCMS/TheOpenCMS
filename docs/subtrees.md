[&larr; Docs](./README.md)

```
```

## Subtrees

This project uses `git subtree` approach. You will find many of dependencies in the folder [Engines](../TheOpenCMS/Engines)

You can change files of the main project and also all dependencies right in the current `master` and push them all together to the main repo of the project. All changes will be stored in the main repo.

If you want to update a specific repo of a dependency then you can do that directly via command `git subtree push`. Also you can use this simple automatic [ruby script](../TheOpenCMS/scripts/subtree) to updated a few dependencies in the same time.

Examples:

```ruby
TheOpenCMS/scripts/subtree [ add | push | pull ] the_open_cms
TheOpenCMS/scripts/subtree [ add | push | pull ] protozaur
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
