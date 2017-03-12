NotificationTool = toastr

@Notifications = do ->
  clear: -> @clean()
  clean: -> NotificationTool.clear()

  show_error: (error) ->
    NotificationTool.error(error) if error

  show_errors: (errors) ->
    for field, errs of errors
      for err in errs
        NotificationTool.error "<b>#{ field }:</b> #{ err }"

  show_flash: (flash) ->
    fu =
      info:    'info'
      notice:  'info'
      errors:  'error'
      error:   'error'
      warning: 'warning'
      alert:   'warning'

    for level, msg of flash
      method = fu[level] || 'info'

      if msg instanceof Array
        for _msg in msg
          NotificationTool[method] _msg
      else
        NotificationTool[method] msg

  show_notifications: ->
    data = window.notifications
    return false unless data

    @show_errors errors if errors = data?.errors
    @show_flash  flash  if flash  = data?.flash

  click_for_close_init: ->
    $(document).on 'click', '.flash_msgs, .error_explanation', (e) ->
      $(e.currentTarget).slideUp(500)

  turbolinks_init: ->
    $(document).on 'page:before-unload', (e) ->
      window.notifications = undefined

  init: ->
    @inited ||= do =>
      @click_for_close_init()
      @turbolinks_init() if Turbolinks?
