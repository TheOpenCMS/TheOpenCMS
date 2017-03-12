@LogJS = do ->
  init: ->
    @enable ||= $('[data-log-js]').length

@log = ->
  try
    if LogJS.enable
      console.log arguments...

$ -> do LogJS.init
