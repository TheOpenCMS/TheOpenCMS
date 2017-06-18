# include ::ThePublication::ControllerLayout
module ThePublication
  module ControllerLayout
    extend ActiveSupport::Concern

    included do
      layout ->{ publication_layout }
    end

    private

    def publication_layout
      no_layout = %w[print]
      frontent_layout = %w[index show]

      return false if no_layout.include?(action_name)
      return 'the_publication_frontend' if frontent_layout.include?(action_name)
      'the_publication_backend'
    end
  end # ControllerLayout
end
