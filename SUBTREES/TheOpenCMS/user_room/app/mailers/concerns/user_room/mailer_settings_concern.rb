# include ::UserRoom::MailerSettingsConcern
module UserRoom
  module MailerSettingsConcern
    extend ActiveSupport::Concern

    class_methods do
      def smtp?
        ['smtp', 'letter_opener'].include?(::Settings.app.mailer.service)
      end
    end

    # SomeMailer.test_mail.delivery_method.settings
    #
    included do
      if smtp?
        _mailer = ::Settings.app.mailer

        default bcc:  _mailer.admin_email
        default from: _mailer.smtp.default.user_name

        def self.smtp_settings
          ::Settings.app.mailer.smtp.default.to_h
        end
      end
    end
  end
end
