$(document).on 'ready turbolinks:load',  ->
  do SelectLocale.init
  do Notifications.init
  do PubCodeMirror.init
