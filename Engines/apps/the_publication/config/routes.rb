module ThePublication
  # ::ThePublication::Routes.mixin(self, :article)
  class Routes
    def self.mixin mapper, model_name
      model_name = model_name.to_s.pluralize.to_sym
      mapper.extend ::ThePublication::BaseRoutes
      mapper.send :the_publication_routes, model_name
    end
  end # class Routes

  module BaseRoutes
    def the_publication_routes(model_name)
      resources model_name do
        collection do
          get :manage
        end
      end
    end
  end # module Routes
end
