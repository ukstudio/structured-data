module StructuredData
  module RailsExtentions
    module SiteNavigationElement
      def self.included(controller)
        controller.helper_method :set_site_navigation_element
      end

      def site_navigation_element
        @site_navigation_element ||= StructuredData::SiteNavigationElement.new
      end

      def set_site_navigation_element(url:, name:)
        site_navigation_element << { url: url, name: name }
      end
    end
  end
end
