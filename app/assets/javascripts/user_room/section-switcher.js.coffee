@SectionSwitcher = do ->
  init: ->
    $('.js-section-switcher--block').on 'click', (e) ->
      item = $ e.currentTarget

      $('.js-section-switcher--list').show()
      $('.js-section-switcher--hide-canvas').show()

    $('.js-section-switcher--hide-canvas').on 'click', (e) ->
      item = $ e.currentTarget

      $('.js-section-switcher--list').hide()
      $('.js-section-switcher--hide-canvas').hide()

      false
