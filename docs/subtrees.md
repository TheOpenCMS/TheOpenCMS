## Subtrees

This project uses git subtrees to manage dependencies and to maintain gems and solutions which could be helpful between different Rails projects.

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
