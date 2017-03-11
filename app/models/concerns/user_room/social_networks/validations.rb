module UserRoom
  module SocialNetworks
    module Validations

      extend ActiveSupport::Concern

      included do
        validate :social_networks_urls
      end

      def social_networks_urls
        fb, vk, tw, ig, pt, gp = !fb_addr.blank?, !vk_addr.blank?, !tw_addr.blank?, !ig_addr.blank?, !pt_addr.blank?, !gp_addr.blank?
        return true if !fb && !vk && !tw && !ig && !pt && !gp

        if gp
          gp_1 = gp_addr.match(/^(http:\/\/|https:\/\/)(www.)?plus.google.com\/\S/)

          unless gp && gp_1
            errors.add "GooglePlus", "Адрес Google plus должен быть вида: http://plus.google.com/login"
          end
        end

        if pt
          pt_1 = pt_addr.match(/^(http:\/\/|https:\/\/)(www.)?pinterest.com\/\S/)

          unless pt && pt_1
            errors.add :pinterest, "Адрес Pinterest должен быть вида: http://pinterest.com/login"
          end
        end

        if ig
          ig_1 = ig_addr.match(/^(http:\/\/|https:\/\/)(www.)?instagram.com\/\S/)

          unless ig && ig_1
            errors.add :instagram, "Адрес Instagram должен быть вида: http://instagram.com/login"
          end
        end

        if fb
          fb_1 = fb_addr.match(/^(http:\/\/|https:\/\/)(www.)?facebook.com\/\S/)
          fb_2 = fb_addr.match(/^(http:\/\/|https:\/\/)(www.)?fb.com\/\S/)

          unless fb && (fb_1 || fb_2)
            errors.add :facebook, "Адрес на Facebook должен быть вида: http://facebook.com/login"
          end
        end

        if vk
          unless vk && vk_addr.match(/^(http:\/\/|https:\/\/)(www.)?vk.com\/\S/)
            errors.add :vkontakte, "Адрес на VK должен быть вида: http://vk.com/login"
          end
        end

        if tw
          unless tw && tw_addr.match(/^(http:\/\/|https:\/\/)(www.)?twitter.com\/\S/)
            errors.add :twitter, "Адрес на Twitter должен быть вида: http://twitter.com/login"
          end
        end
      end

    end # Validations
  end # SocialNetworks
end # UserRoom
