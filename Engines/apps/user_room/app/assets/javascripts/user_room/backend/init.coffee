$(document).on 'ready turbolinks:load',  ->
  do CropTool.init
  do SelectLocale.init
  do Notifications.init
  do SocialLoginButtons.init
