# include ::ThePublication::ControllerLayout
module ThePublication
  module ControllerLayout
    extend ActiveSupport::Concern

    included do
      layout ->{ publication_layout }
    end

    private

    def publication_layout
      false if %w[print].include?(action_name)
      return 'the_publication_frontend' if %w[index show].include?(action_name)
      'the_publication_backend'
    end
  end # ControllerLayout
end
