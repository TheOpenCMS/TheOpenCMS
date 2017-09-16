@PubCodeMirror = do ->
  init: ->
    log('Init Code Mirror Editors')

    require [
      'code_mirror/code_mirror/lib/codemirror'
      'code_mirror/code_mirror/mode/markdown/markdown'
    ], (CodeMirror) ->
      window.CodeMirror ||= CodeMirror
      PubCodeMirror.init_items()

  init_items: ->
    for editor_id in ['#pub_intro', '#pub_content']
      myTextArea = $(editor_id)

      if myTextArea.length
        unless myTextArea.data('CodeMirror')
          cm = CodeMirror.fromTextArea(myTextArea[0],
            lineNumbers: true
            mode: "markdown"
            matchBrackets: true
          )
          myTextArea.data('CodeMirror', cm)
