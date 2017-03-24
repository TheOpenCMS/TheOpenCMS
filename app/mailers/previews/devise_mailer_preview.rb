class DeviseMailerPreview < ActionMailer::Preview
  def DEVISE_reset_password_instructions
    ::DeviseMailer.reset_password_instructions(User.last, {})
  end

  def DEVISE_confirmation_instructions
    ::DeviseMailer.confirmation_instructions(User.last, {})
  end

  def DEVISE_MailRegistrationRequest
    reg_req = ::EmailRegistrationRequest.last
    ::DeviseMailer.mail_registration_request(reg_req.id, callback_path = '/orders/09dfr12')
  end

  def DEVISE_OnetimeLoginRequest
    log_req = ::OnetimeLoginLink.last
    ::DeviseMailer.onetime_login_request(log_req.id, callback_path = '/orders/09dfr12')
  end

  def DEVISE_New_user_created
    user_id = User.first.id
    ::DeviseMailer.new_user_created(user_id)
  end
end
