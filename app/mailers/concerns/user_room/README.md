```ruby
class MailerPreview < ActionMailer::Preview
  def DEVISE_reset_password_instructions
    DeviseMailer.reset_password_instructions(User.last, {})
  end

  def DEVISE_confirmation_instructions
    DeviseMailer.confirmation_instructions(User.last, {})
  end

  def DEVISE_MailRegistrationRequest
    reg_req = EmailRegistrationRequest.last
    DeviseMailer.mail_registration_request(reg_req.id, callback_path = '/orders/09dfr12')
  end

  def DEVISE_OnetimeLoginRequest
    log_req = OnetimeLoginLink.last
    DeviseMailer.onetime_login_request(log_req.id, callback_path = '/orders/09dfr12')
  end

  def DEVISE_New_user_created
    user_id = User.first.id
    DeviseMailer.new_user_created(user_id)
  end
end
```

```
EmailRegistrationRequest.create
OnetimeLoginLink.create
```

`app_view/mailers/devise_mailer.rb`

```
class DeviseMailer < Devise::Mailer
  include ::UserRoom::MailerSettingsConcern
  include ::UserRoom::DeviseMailerExtention

  private

  def set_attachments!
    # Add common attached files here

    # @images = {
    #   'logo.png'      => '/logos/w350_h100.png',
    #   'shop_logo.png' => '/logos/shop_w350_h100.png'
    # }
    # @images.each_pair do |name, path|
    #   attachments.inline[name] = File.read("#{ Rails.root }/public/#{ path }")
    # end
  end
end
```
