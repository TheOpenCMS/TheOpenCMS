module AppBase
  class Engine < Rails::Engine
    initializer :add_app_base_engine_view_paths do
      ActiveSupport.on_load(:action_mailer) do
        if respond_to?(:prepend_view_path)
          gem_root = ::AppBase::Engine.config.root
          prepend_view_path("#{ gem_root }/app/mailers")
          prepend_view_path("#{ gem_root }/app/mailers/views/app_base")
        end
      end
    end # initializer
  end
end
