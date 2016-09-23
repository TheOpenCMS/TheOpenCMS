@Notes = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'click', '.js-notes-random_note', (e) ->
        App.notes.random()
