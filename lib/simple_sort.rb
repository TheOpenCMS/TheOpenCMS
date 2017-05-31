module SimpleSort
  class Engine < Rails::Engine; end

  module Base
    extend ActiveSupport::Concern

    # HELPERS
    class_methods do
      # TODO: private?
      def ss_available_fields_filter fields
        available_fields = self.columns.map(&:name)

        fields.inject([]) do |ary, field|
          ary.push(field) if available_fields.include?(field.to_s)
          ary
        end
      end

      def ss_table_field_order_sql fields
        fields.map{ |field| "#{ table_name }.#{ field }" }.join(', ')
      end
    end

    included do
      # RANDOM

      scope :random, ->{
        @adapter_name ||= ActiveRecord::Base.connection.adapter_name
        (@adapter_name == "PostgreSQL") ? psql_random : mysql_random
      }

      scope :mysql_random, ->{ reorder('RAND()')   }
      scope :psql_random,  ->{ reorder('RANDOM()') }

      # WITH FIELDS CHECKING

      scope :max2min, ->(fields = [:id]) {
        fields  = Array.wrap fields
        return nil if fields.blank?

        fields  = ss_available_fields_filter( fields )
        return nil if fields.blank?

        sql_str = ss_table_field_order_sql( fields )
        reorder("#{ sql_str } DESC")
      }

      scope :min2max, ->(fields = [:id]) {
        fields  = Array.wrap fields
        return nil if fields.blank?

        fields  = ss_available_fields_filter( fields )
        return nil if fields.blank?

        sql_str = ss_table_field_order_sql( fields )
        reorder("#{ sql_str } ASC")
      }

      scope :simple_sort, ->(params, default_sort_field = nil){
        sort_column = params[:sort_column]
        sort_type   = params[:sort_type]

        return max2min(default_sort_field) unless sort_column
        return max2min(sort_column)        unless sort_type

        sort_type.downcase == 'asc' ? max2min(sort_column) : min2max(sort_column)
      }

      # WITHOUT FIELDS CHECKING

      scope :_max2min, ->(fields = [:id]) {
        fields  = Array.wrap fields
        return nil if fields.blank?
        reorder("#{ fields.join(',') } ASC")
      }

      scope :_min2max, ->(fields = [:id]) {
        fields  = Array.wrap fields
        return nil if fields.blank?
        reorder("#{ fields.join(',') } DESC")
      }

      scope :_simple_sort, ->(params, default_sort_field = nil){
        sort_column = params[:sort_column]
        sort_type   = params[:sort_type]

        return _max2min(default_sort_field) unless sort_column
        return _max2min(sort_column)        unless sort_type

        sort_type.downcase == 'asc' ? _max2min(sort_column) : _min2max(sort_column)
      }
    end
  end
end
