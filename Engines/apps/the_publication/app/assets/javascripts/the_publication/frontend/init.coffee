@AppInit ||= do ->
  init: ->
    do SelectLocale.init
    do Notifications.init
