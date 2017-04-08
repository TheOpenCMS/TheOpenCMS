# include ::Notifications::LocalizedErrors
module Notifications
  module LocalizedErrors
    extend ActiveSupport::Concern

    # @post.localized_errors(except: [:'comment.title'])
    def localized_errors opts = {}
      opts.symbolize_keys!
      excepts = opts.delete(:except) || []

      errors.inject({}) do |hash, (k, v)|
        unless excepts.include?(k.to_sym)
          k = self.class.human_attribute_name k
          hash[k].blank? ? hash[k] = [v] : hash[k].push(v)
          hash[k].uniq!
        end

        hash
      end
    end

    # @post.inline_localized_errors(except: [:'comment.title'])
    def inline_localized_errors opts = {}
      opts.symbolize_keys!
      excepts = opts.delete(:except) || []

      errors.inject({}) do |hash, (k, v)|
        unless excepts.include?(k.to_sym)
          name = self.class.human_attribute_name k
          key  = "#{ self.class }/#{ k }".parameterize.underscore.camelcase

          hash[key]       = {} if hash[key].blank?
          hash[key][name] = [] if hash[key][name].blank?
          hash[key][name].push(v)
        end

        hash
      end
    end
  end
end
