require "kaminari"

module Pagination
  class Engine < Rails::Engine; end

  module Base
    extend ActiveSupport::Concern

    # for example: per_page_kaminari
    def self.per_method
      @per ||= :per
    end

    class_methods do
      def pagination params
        per_method = ::Pagination::Base.per_method
        page(params[:page]).send(::Pagination::Base.per_method, params[:per_page])
      end
    end
  end
end
