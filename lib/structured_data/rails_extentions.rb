module StructuredData
  module RailsExtentions
    def self.included(controller)
      controller.helper_method :repository
      controller.helper_method :display_structured_data

      controller.include StructuredData::RailsExtentions::BreadclumbList
      controller.include StructuredData::RailsExtentions::SiteNavigationElement
    end

    def repository
      @structured_data_repository ||= StructuredData::Repository.new
    end

    def display_structured_data
      repository << breadcrumb_list unless breadcrumb_list.empty?
      repository << site_navigation_element unless site_navigation_element.empty?

      view_context.content_tag(:script, repository.dump.html_safe, type: 'application/ld+json')
    end
  end
end

require 'structured_data/rails_extentions/breadcrumb_list'
require 'structured_data/rails_extentions/site_navigation_element'
