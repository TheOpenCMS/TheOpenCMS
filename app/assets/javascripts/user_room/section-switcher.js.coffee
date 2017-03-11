@SectionSwitcher = do ->
  init: ->
    $('@section-switcher--block').on 'click', (e) ->
      item = $ e.currentTarget

      $('@section-switcher--list').show()
      $('@section-switcher--hide-canvas').show()

    $('@section-switcher--hide-canvas').on 'click', (e) ->
      item = $ e.currentTarget

      $('@section-switcher--list').hide()
      $('@section-switcher--hide-canvas').hide()

      false
