@Notifications = do ->
  # clear: -> @clean()
  # clean: -> NotificationTool.clear()
  #
  # show_error: (error) ->
  #   NotificationTool.error(error) if error
  #
  # show_errors: (errors) ->
  #   for field, errs of errors
  #     for err in errs
  #       NotificationTool.error "<b>#{ field }:</b> #{ err }"
  #
  # show_flash: (flash) ->
  #   fu =
  #     info:    'info'
  #     notice:  'info'
  #     errors:  'error'
  #     error:   'error'
  #     warning: 'warning'
  #     alert:   'warning'
  #
  #   for level, msg of flash
  #     method = fu[level] || 'info'
  #
  #     if msg instanceof Array
  #       for _msg in msg
  #         NotificationTool[method] _msg
  #     else
  #       NotificationTool[method] msg
  #
  show_notifications: ->
    # data = window.notifications
    # return false unless data
    #
    # @show_errors errors if errors = data?.errors
    # @show_flash  flash  if flash  = data?.flash

  init_click_to_close: ->
    $(document).on 'click', '.js-notifications-block', (e) ->
      $(e.currentTarget).slideUp(500)

  init_for_turbolinks: ->
    $(document).on 'turbolinks:before-render', (e) ->
      window.notifications = undefined

  init: ->
    do @show_notifications

    @inited ||= do =>
      do @init_click_to_close
      do @init_for_turbolinks if Turbolinks?
