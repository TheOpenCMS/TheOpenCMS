class AppTestMailerPreview < ActionMailer::Preview
  def test_email
    AppTestMailer.test_email('test-inbox@example.com')
  end
end
