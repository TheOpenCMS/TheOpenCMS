@AppInit ||= do ->
  init: ->
    do SelectLocale.init
    do Notifications.init
    do @initContentEditors

  initContentEditors: ->
    content_editor_name = window.CONTENT_EDITOR?.name

    if content_editor_name is 'code_mirror'
      do PubCodeMirror.init

    if content_editor_name is 'ckeditor'
      do PubCKEditor.init

$ ->
  do AppInit.init
