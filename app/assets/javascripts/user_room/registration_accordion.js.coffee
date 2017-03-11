@RegistrationAccordion = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'click', '@registration-accordion--switcher', (e) ->
        switcher = $ e.currentTarget
        holder   = switcher.parents '@registration-accordion'

        if holder.find('@registration-accordion--intro:visible').length
          # hide all
          holders = $('@registration-accordion').not(holder)
          holders.addClass 'disable'
          holders.find('@registration-accordion--content').slideUp ->
            holders.find('@registration-accordion--intro').slideDown()

          # show that
          holder.removeClass 'disable'
          holder.find('@registration-accordion--intro').slideUp ->
            holder.find('@registration-accordion--content').slideDown()
