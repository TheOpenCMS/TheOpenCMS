@PubCodeMirror = do ->
  editor_included: -> typeof(CodeMirror) isnt 'undefined'

  init: ->
    try
      if PubCodeMirror.editor_included()
        PubCodeMirror.editors_setup()
      else
        PubCodeMirror.retry()
    catch e
      log e
      PubCodeMirror.retry()
      log 'CodeMirror is not loaded'

  retry: ->
    setTimeout =>
      if PubCodeMirror.editor_included()
        PubCodeMirror.editors_setup()
    , 2000

  editors_setup: ->
    console.log('Init Editors')

    myTextArea = $('#pub_intro')[0]
    CodeMirror.fromTextArea(myTextArea,
      lineNumbers: true
      mode: "markdown"
      matchBrackets: true
    )

    myTextArea = $('#pub_content')[0]
    CodeMirror.fromTextArea(myTextArea,
      lineNumbers: true
      mode: "markdown"
      matchBrackets: true
    )
