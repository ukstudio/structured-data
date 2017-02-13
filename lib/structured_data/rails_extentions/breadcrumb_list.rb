module StructuredData
  module RailsExtentions
    module BreadclumbList
      def self.included(controller)
        controller.helper_method :set_breadcrumb_item
      end

      def breadcrumb_list
        @breadcrumb_list ||= StructuredData::BreadcrumbList.new
      end

      def set_breadcrumb_item(url:, name:)
        breadcrumb_list << { url: url, name: name }
      end
    end
  end
end
