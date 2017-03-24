$(document).on 'ready turbolinks:load',  ->
  log 'Ready!'
  do SectionSwitcher.init
  do SocialLoginButtons.init
  do RegistrationAccordion.init
