class AppTestMailer < AppBaseMailer
  # AppTestMailer.test_email.deliver_now
  # AppTestMailer.test_email('myinbox@example.com').deliver_now

  def test_email(email = nil)
    addresser = email || Settings.app.mailer.admin_email

    mail(
      to: addresser,
      subject: 'TheOpenCMS test email'
    )
  end
end
