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

      ##########################################
      ### Validations
      ##########################################

      validates :login, presence: true, uniqueness: true, on: :update, if: :login_changed?
      validate  :login_validations, on: :update, if: :login_changed?
      validates :password, length: { minimum: 6 }, if: ->{ password.present? }

      ##########################################
      ### Callbacks
      ##########################################

      after_create :create_default_login

      ##########################################
      ### Relations
      ##########################################

      has_many :orders

      ##########################################
      ### Other methods
      ##########################################

      def to_param
        self.login
      end

      private

      def create_default_login
        self.login = "id#{self.id}"
      end

      def login_validations
        unless (self.login =~ /[a-zA-Z]/mix)
          errors.add(:login, "has to have a one of more letters")
        end

        if self.login =~ /^id/mix
          if self.login.downcase != "id#{self.id}"
            errors.add(:login, "This Login could not be used")
          end
        end
      end

    end # included do
  end # User
end # UserRoom
