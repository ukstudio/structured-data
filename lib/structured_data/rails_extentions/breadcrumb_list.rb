module StructuredData
  module RailsExtentions
    module BreadclumbList
      def self.included(controller)
        controller.helper_method :breadcrumb_list
        controller.helper_method :set_breadcrumb_list_item
      end

      def breadcrumb_list(&block)
        @breadcrumb_list ||= StructuredData::BreadcrumbList.new

        if block_given?
          @breadcrumb_list.instance_eval(&block)
        else
          @breadcrumb_list
        end
      end

      def set_breadcrumb_list_item(url:, name:)
        breadcrumb_list << { url: url, name: name }
      end
    end
  end
end
