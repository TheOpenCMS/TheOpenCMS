class DeviseMailer < Devise::Mailer
  include ::UserRoom::MailerSettingsConcern

  layout 'user_room/layouts/mailers/user_room'
  default template_path: [ 'user_room/devise/mailer' ]

  # Additional Mailers
  # id = EmailRegistrationRequest.last.id
  # DeviseMailer.mail_registration_request(id, '').deliver_now
  def mail_registration_request(id, callback_path = nil)
    reg_req = ::EmailRegistrationRequest.find(id)

    @uid = reg_req.uid
    @email = reg_req.email
    @callback_path = callback_path
    @subject = _t_subjects(:mail_registration_request)

    mail(to: @email, subject: @subject)
  end

  # id = OnetimeLoginLink.last.id
  # DeviseMailer.onetime_login_request(id, '').deliver_now
  def onetime_login_request(id, callback_path = nil)
    log_req  = ::OnetimeLoginLink.find(id)

    @uid = log_req.uid
    @email = log_req.email
    @callback_path = callback_path
    @subject = _t_subjects(:onetime_login_request)

    mail(to: @email, subject: @subject)
  end

  # DeviseMailer.new_user_created(user_id)
  def new_user_created(user_id)
    @user  = ::User.find(user_id)
    @email = ::Settings.app.mailer.admin_email
    @subject = _t_subjects(:new_user_created)

    mail(to: @email, subject: @subject)
  end

  def confirmation_instructions(record, token, opts={})
    @subject = _t_subjects(:confirmation_instructions)
    super
  end

  def reset_password_instructions(record, token, opts={})
    @subject = _t_subjects(:reset_password_instructions)
    super
  end

  private

  def _t_subjects(name)
    t(name, scope: 'user_room.mailer.subjects')
  end
end
