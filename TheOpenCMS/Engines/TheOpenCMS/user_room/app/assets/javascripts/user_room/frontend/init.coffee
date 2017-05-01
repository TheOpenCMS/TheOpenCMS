$(document).on 'ready turbolinks:load',  ->
  do SelectLocale.init
  do Notifications.init
  do SectionSwitcher.init
  do SocialLoginButtons.init
  do RegistrationAccordion.init
