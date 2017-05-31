module UserRoom
  module SocialNetworks
    module Login

      extend ActiveSupport::Concern

      # `User` model have to have the following fields
      #
      # gp_addr
      # fb_addr
      # vk_addr
      # tw_addr
      # ok_addr
      #
      # has_many :credentials

      class_methods do
        def networks_list
          %w[ vkontakte facebook twitter google_oauth2 odnoklassniki ]
        end

        def social_networks_hash
          {
            gp: :Google,
            fb: :Facebook,
            vk: :Vkontakte,
            tw: :Twitter,
            ok: :Odnoklassniki
          }
        end

        def social_networks_hash2
          {
            gp: :google_oauth2,
            fb: :facebook,
            vk: :vkontakte,
            tw: :twitter,
            ok: :odnoklassniki
          }
        end
      end # class_methods

      def actual_email
        return '' if email.match(/#{ oauth_default_email_domain }/mix)
        email
      end

      included do
        attr_accessor :oauth_data

        has_many :credentials, dependent: :destroy
        before_validation :oauth_actions, on: :create, if: ->{ oauth? }

        validate :uniq_credential, if: ->{ oauth? }

        # =================================================
        # CREDANTIALS
        # =================================================

        def oauth_create_credential!
          uid          = oauth_params['uid']
          provider     = oauth_params['provider']
          _credentials = oauth_params.try(:[], 'credentials')

          exp_date = nil
          exp_date = (Time.now + _credentials['expires_at'].to_i.seconds) if _credentials['expires_at'].present?

          credentials_record = credentials.where(provider: provider).first

          if credentials_record.blank?
            credentials_record = credentials.create(
              uid:        uid,
              provider:   provider,
              expires_at: exp_date,
              access_token: _credentials['token'],
              access_token_secret: _credentials['secret'] # twitter
            )
          end

          credentials_record
        end

        def add_credential(omniauth)
          uid          = omniauth['uid']
          provider     = omniauth['provider']
          _credentials = omniauth.try(:[], 'credentials')

          exp_date = nil
          exp_date = (Time.now + _credentials['expires_at'].to_i.seconds) if _credentials['expires_at'].present?

          credentials_record = credentials.where(provider: provider).first

          if credentials_record.blank?
            credentials_record = credentials.create(
              uid:        uid,
              provider:   provider,
              expires_at: exp_date,
              access_token: _credentials['token'],
              access_token_secret: _credentials['secret'] # twitter
            )
          end

          credentials_record
        end

        def reset_oauth_data!
          self.oauth_data, @oauth_params = [ nil, nil ]
        end

        private

        def oauth_actions
          oauth_set_email
          oauth_set_password

          oauth_set_login
          oauth_set_username
          oauth_set_avatar_url

          oauth_set_common_params
          oauth_set_social_network_url
        end

        def oauth_default_email_domain
          'theopencms.org'
        end

        # USER SIDE VARIABLES
        def oauth_set_username
          self.username = info.try(:[], 'name')
        end

        def oauth_set_login
          self.login = raw_info.try(:[], 'screen_name') if vk_oauth?
          self.login = info.try(:[], 'nickname')        if tw_oauth?
        end

        def oauth_set_email
          self.email   = "#{ SecureRandom.hex[0..6] }@#{ oauth_default_email_domain }"
          self.email ||= info.try(:[], 'email')
        end

        def oauth_set_password
          self.password = SecureRandom.hex[0..10]
        end

        # =================================================
        # OAUTH SET/UPDATE VARIABLES
        # =================================================

        def oauth_set_avatar_url
          # self.avatar_url = oauth_get_avatar_url
          self.avatar = ::URI.parse oauth_get_avatar_url
        end

        def oauth_set_common_params
          # set something common here
        end

        def oauth_set_social_network_url omniauth = nil
          _info = omniauth ? omniauth.try(:[], 'info') : info

          if _info.present?
            ::User.social_networks_hash.each_pair do |key, name|
              network_field = "#{ key }_addr" # fb_addr

              # if self.respond_to?('fb_addr') && self.fb_addr.blank?
              if self.respond_to?(network_field) && self.send(network_field).blank?
                # social_network_url = info['urls']['Google']
                # self.fb_addr = social_network_url
                social_network_url = _info.try(:[], 'urls').try(:[], name.to_s)
                self.try "#{ network_field }=", social_network_url
              end
            end # each_pair
          end # if _info.present?
        end

        # =================================================
        # OAUTH helpers
        # =================================================

        def oauth?; oauth_data.present?; end

        ::User.social_networks_hash2.each_pair do |k, name|
          # EXAMPLE: def og_oauth?; oauth_params['provider'] == 'facebook'; end
          define_method "#{ k }_oauth?" do
            oauth_params['provider'] == name.to_s
          end
        end

        def oauth_params
          @oauth_params ||= (begin; JSON.parse oauth_data; rescue; oauth_data; end)
        end

        def info
          @info ||= oauth_params.try(:[], 'info')
        end

        def extra
          @extra ||= oauth_params.try(:[], 'extra')
        end

        def raw_info
          @raw_info ||= oauth_params.try(:[], 'extra').try(:[], 'raw_info')
        end

        # =================================================
        # AVATAR
        # =================================================

        def oauth_get_avatar_url
          avatar = info.try(:[], 'image')
          gp_avatar, fb_avatar, tw_avatar = Array.new(3, avatar)

          if fb_oauth?
            json   = ::JSON.parse(Net::HTTP.get(URI.parse(fb_avatar.gsub('&redirect=false', '') + '?type=large&redirect=false')))
            avatar = json['data']['url'] unless json['data']['is_silhouette']
          end

          if tw_oauth?
            avatar = tw_avatar.gsub('_normal', '')
          end

          if vk_oauth?
            avatar = raw_info.try(:[], 'photo_200_orig')
          end

          if gp_oauth?
            avatar = gp_avatar.gsub('s50', 's200').gsub('sz=50', 'sz=200')
          end

          if ok_oauth?
            avatar = raw_info.try(:[], 'pic_2')
          end

          avatar
        end

        # =================================================
        # VALIDATION
        # =================================================
        def uniq_credential
          uid      = oauth_params['uid']
          provider = oauth_params['provider']

          if ::Credential.find_by_uid_and_provider(uid, provider)
            errors.add :credentials, :uniqueness
          end
        end
      end # included

    end # Login
  end # SocialNetworks
end # UserRoom

# ru:
#   activerecord:
#     attributes:
#       user:
#         credentials: "Аккаунт социальной сети"
#     errors:
#       models:
#         user:
#           attributes:
#             credentials:
#               uniqueness: "уже привязан к другому пользователю"
