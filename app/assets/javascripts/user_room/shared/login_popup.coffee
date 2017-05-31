@SocialLoginButtons = do ->
  popupCenter: (name, url, width, height) ->
    left = (screen.width  / 2) - (width  / 2)
    top  = (screen.height / 2) - (height / 2) - 50

    popup = window.open url, name, """
      menubar=no, toolbar=no, status=no,
      width=#{ width }, height=#{ height },
      left=#{ left }, top=#{ top }
    """

    do popup.focus

  init: ->
    $('.js-social_login-btn').click (e) ->
      btn = $ e.target

      SocialLoginButtons.popupCenter(
        'authPopup',
        btn.attr('href'),
        (btn.attr('data-width')  || 600),
        (btn.attr('data-height') || 600)
      )

      false
