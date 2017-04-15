class AppTestMailer < AppBaseMailer
  def test_email
    mail(
      to: Settings.app.mailer.admin_email,
      subject: 'TheOpenCMS test email'
    )
  end
end
