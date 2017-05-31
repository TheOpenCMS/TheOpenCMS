@SectionSwitcher = do ->
  init: ->
    $('.js-section_switcher-block').on 'click', (e) ->
      item = $ e.currentTarget

      $('.js-section_switcher-list').show()
      $('.js-section_switcher-hide_canvas').show()

    $('.js-section_switcher-hide_canvas').on 'click', (e) ->
      item = $ e.currentTarget

      $('.js-section_switcher-list').hide()
      $('.js-section_switcher-hide_canvas').hide()

      false
