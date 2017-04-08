@LogJS = do ->
  init: ->
    @enable ||= document.getElementsByClassName('log-js').length > 0
    @enable = true if window.location.search.match(/log\-js/i)

@log = ->
  try
    if LogJS.enable
      console.log arguments...

do @LogJS.init
