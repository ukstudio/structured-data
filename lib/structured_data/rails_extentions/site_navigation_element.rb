module StructuredData
  module RailsExtentions
    module SiteNavigationElement
      def self.included(controller)
        controller.helper_method :site_navigation_element
        controller.helper_method :set_site_navigation_element_item
      end

      def site_navigation_element
        @site_navigation_element ||= StructuredData::SiteNavigationElement.new

        if block_given?
          yield @@site_navigation_element
        else
          @site_navigation_element
        end
      end

      def set_site_navigation_element_item(url:, name:)
        site_navigation_element << { url: url, name: name }
      end
    end
  end
end
