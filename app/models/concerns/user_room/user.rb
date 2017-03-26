module UserRoom
  module User
    extend ActiveSupport::Concern

    included do
      devise :database_authenticatable,
        :confirmable,
        :recoverable,
        :validatable,
        :registerable,
        :rememberable,
        :omniauthable,
        :omniauth_providers => %w[
          facebook
          twitter
          vkontakte
          google_oauth2
          odnoklassniki
        ]

      include ::SimpleSort::Base
      include ::Pagination::Base
      include ::Notifications::LocalizedErrors

      include ::UserRoom::UserAvatar
      include ::UserRoom::SocialNetworks::Login
      include ::UserRoom::SocialNetworks::Validations

      before_validation :create_default_login, on: :create
      before_validation :prepare_login
      before_validation :set_login_if_this_login_already_exists_or_blank, on: :create

      # Validations
      validates :login, presence: true, uniqueness: true
      validate  :login_chars_required

      validates :password, length: { minimum: 6 }, if: ->{ password.present? }

      has_many :orders

      def login_chars_required
        errors.add(:login, "has to have a one of more letters") unless (self.login =~ /[a-zA-Z]/mix)
      end

      private

      def create_default_login
        _login = "user-#{ SecureRandom.hex[0..4] }"
        self.login = self.login.blank? ? _login : self.login
      end

      def prepare_login
        self.login = self.login.to_s.to_slug_param
      end

      def set_login_if_this_login_already_exists_or_blank
        if self.class.where(login: self.login).first || self.login.blank?
          self.login = "user-#{ SecureRandom.hex[0..6] }"
        end
      end

    end # included
  end # User
end # UserRoom
