@RegistrationAccordion = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'click', '.js-registration-accordion--switcher', (e) ->
        switcher = $ e.currentTarget
        holder   = switcher.parents '.js-registration-accordion'

        if holder.find('.js-registration-accordion--intro:visible').length
          # hide all
          holders = $('.js-registration-accordion').not(holder)
          holders.addClass 'disable'
          holders.find('.js-registration-accordion--content').slideUp ->
            holders.find('.js-registration-accordion--intro').slideDown()

          # show that
          holder.removeClass 'disable'
          holder.find('.js-registration-accordion--intro').slideUp ->
            holder.find('.js-registration-accordion--content').slideDown()
