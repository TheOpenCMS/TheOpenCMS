## CSS code style

### SASS

This project uses [SASS](http://sass-lang.com/) to write `CSS` code. All new CSS code must be written in `SASS`, all old code must be converted to `SASS`

### BEM

This project uses [BEM](https://en.bem.info/) approach to write CSS code.

This project uses its own syntax and way to write BEM classes, but the approach the same.

### BEM delimiters

* `-` &mdash; `minus` to delimit blocks, elements and modifiers
* `_` &mdash; `underscore` to delimit words in blocks, elements and modifiers

### Name of the Block should be used as a scope

There is an example how you have to create BEM structure in your `SASS`

```sass
.custom_search
  &-block
    color: black

  &-item
    margin: 10px

  &-title
    font-size: 18px

  &-text
    font-size: 15px

  &-link
    color: blue

    &:hover
      color: red

  &-input
    padding: 5px

  &-button
    padding: 10px
```

###
