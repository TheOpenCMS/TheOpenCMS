@RegistrationAccordion = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'click', '.js-registration_accordion-switcher', (e) ->
        switcher = $ e.currentTarget
        holder   = switcher.parents '.js-registration_accordion'

        if holder.find('.js-registration_accordion-intro:visible').length
          # hide all
          holders = $('.js-registration_accordion').not(holder)
          holders.addClass 'disable'
          holders.find('.js-registration_accordion-content').slideUp ->
            holders.find('.js-registration_accordion-intro').slideDown()

          # show that
          holder.removeClass 'disable'
          holder.find('.js-registration_accordion-intro').slideUp ->
            holder.find('.js-registration_accordion-content').slideDown()
