@Search = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'click', '.js-search-submit_btn', (e) ->
        btn  = $ e.currentTarget
        form = btn.parents('form')

        q_input = form.find('[name=q]')
        q = q_input.val().trim()
        q_input.val(q)

        return false if q.length == 0

        btn.prop('disabled', 'disabled')
        form.submit()
