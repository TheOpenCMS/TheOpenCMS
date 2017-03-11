module UserRoom
  module Generators
    class ViewsGenerator < Rails::Generators::NamedBase
      source_root UserRoom::Engine.root

      def self.banner
<<-BANNER.chomp

USAGE: [bundle exec] rails g user_room:views OPTION_NAME

> rails g user_room:views js
> rails g user_room:views css
> rails g user_room:views assets

> rails g user_room:views views
> rails g user_room:views all

BANNER
      end

      def copy_sortable_tree_files
        copy_gem_files
      end

      private

      def param_name
        name.downcase
      end

      def copy_gem_files
        case param_name
          when 'js'
            # rails g user_room:views js
            js_copy
          when 'css'
            # rails g user_room:views css
            css_copy
          when 'assets'
            # rails g user_room:views assets
            js_copy
            css_copy
          when 'views'
            # rails g user_room:views views
            views_copy
          when 'devise'
            # rails g user_room:views devise
            devise_copy
          when 'all'
            js_copy
            css_copy
            views_copy
          else
            puts 'UserRoom View Generator - wrong Name'
            puts "Wrong params - use only [ js | css | assets | views | all ] values"
        end
      end

      def js_copy
        d1 = "app_view/assets/javascripts"
        directory d1, d1
      end

      def css_copy
        d1 = "app_view/assets/stylesheets"
        directory d1, d1
      end

      def views_copy
        d1 = "app_view/views/user_room"
        directory d1, d1
      end

      def devise_copy
        d1 = "app_view/views/devise"
        directory d1, d1
      end
    end
  end
end
