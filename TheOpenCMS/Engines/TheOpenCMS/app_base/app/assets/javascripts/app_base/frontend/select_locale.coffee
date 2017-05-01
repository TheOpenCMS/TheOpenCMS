@SelectLocale = do ->
  init: ->
    $(document).on 'change', '.js-select_locale', (e) ->
      select = $(e.currentTarget)
      locale = select.val()

      new_params = []
      params = location.search.slice(1).split('&')

      for param in params
        unless param.match(/^locale=/i)
          new_params.push param

      new_params.push("locale=#{locale}")

      location_base = location.href.split('?')[0]
      location_params = new_params.join('&')

      location.href = [location_base, location_params].join('?')
