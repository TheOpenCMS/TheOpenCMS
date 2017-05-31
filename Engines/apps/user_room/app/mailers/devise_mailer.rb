class DeviseMailer < Devise::Mailer
  def self.smtp?
    ['smtp', 'letter_opener'].include?(::Settings.app.mailer.service)
  end

  if smtp?
    _mailer = ::Settings.app.mailer

    default bcc:  _mailer.admin_email
    default from: _mailer.smtp.default.user_name

    def self.smtp_settings
      ::Settings.app.mailer.smtp.default.to_h
    end
  end

  helper_method :_t_copy
  layout 'layouts/user_room'
  default template_path: ['devise_mailer']

  ######################################################
  # Additional Mailers
  ######################################################

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

  def _t_copy(name)
    t(name, scope: 'user_room.mailer.copies')
  end

  def _t_subjects(name)
    t(name, scope: 'user_room.mailer.subjects')
  end
end
