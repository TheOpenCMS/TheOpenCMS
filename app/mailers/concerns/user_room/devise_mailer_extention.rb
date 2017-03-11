# include ::UserRoom::DeviseMailerExtention
module UserRoom
  module DeviseMailerExtention
    extend ActiveSupport::Concern

    included do
      # Additional Mailers
      # id = EmailRegistrationRequest.last.id
      # DeviseMailer.mail_registration_request(id, '').deliver_now
      def mail_registration_request(id, callback_path = nil)
        reg_req  = ::EmailRegistrationRequest.find(id)

        title    = t(:subject, scope: [:user_room, :mailer, :mail_registration_request])
        @subject = "#{ env_prefix }#{ title }"

        @uid   = reg_req.uid
        @email = reg_req.email
        @callback_path = callback_path

        mail(to: @email, subject: @subject)
      end

      # id = OnetimeLoginLink.last.id
      # DeviseMailer.onetime_login_request(id, '').deliver_now
      def onetime_login_request(id, callback_path = nil)
        log_req  = ::OnetimeLoginLink.find(id)

        title    = t(:subject, scope: [:user_room, :mailer, :onetime_login_request])
        @subject = "#{ env_prefix }#{ title }"

        @uid   = log_req.uid
        @email = log_req.email
        @callback_path = callback_path

        mail(to: @email, subject: @subject)
      end

      # DeviseMailer.new_user_created(user_id)
      def new_user_created(user_id)
        @user  = ::User.find(user_id)
        @email = ::Settings.app.mailer.admin_email

        title    = t(:subject, scope: [:user_room, :mailer, :new_user_created])
        @subject = "#{ env_prefix }#{ title }"

        mail(to: @email, subject: @subject)
      end

      def confirmation_instructions(record, token, opts={})
        title    = t(:subject, scope: [:user_room, :mailer, :confirmation_instructions])
        @subject = "#{ env_prefix }#{ title }"

        super
      end

      def reset_password_instructions(record, token, opts={})
        title    = t(:subject, scope: [:user_room, :mailer, :reset_password_instructions])
        @subject = "#{ env_prefix }#{ title }"

        super
      end
    end
  end
end