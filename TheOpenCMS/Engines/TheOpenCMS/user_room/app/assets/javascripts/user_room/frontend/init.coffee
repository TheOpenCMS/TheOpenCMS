$(document).on 'ready turbolinks:load',  ->
  do Notifications.init
  do SectionSwitcher.init
  do SocialLoginButtons.init
  do RegistrationAccordion.init
