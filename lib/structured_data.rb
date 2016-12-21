require 'action_controller'
require 'action_view'
require 'json'

module StructuredData
  module ViewHelper
    def repository
      @structured_data_repository ||= StructuredData::Repository.new
    end

    def breadcrumb_list
      @breadcrumb_list ||= StructuredData::BreadcrumbList.new
    end

    def set_breadcrumb_item(url:, name:)
      breadcrumb_list << { url: url, name: name }
    end

    def site_navigation_element
      @site_navigation_element ||= StructuredData::SiteNavigationElement.new
    end

    def set_site_navigation_element(url:, name:)
      site_navigation_element << { url: url, name: name }
    end

    def display_strctured_data
      repository << breadcrumb_list unless breadcrumb_list.empty?
      repository << site_navigation_element unless site_navigation_element.empty?

      self.content_tag(:script, repository.dump.html_safe, type: 'application/ld+json')
    end
  end

  module ControllerHelper
    def breadcrumb_list
      @breadcrumb_list ||= StructuredData::BreadcrumbList.new
    end

    def set_breadcrumb_item(url:, name:)
      breadcrumb_list << { url: url, name: name }
    end

    def site_navigation_element
      @site_navigation_element ||= StructuredData::SiteNavigationElement.new
    end

    def set_site_navigation_element(url:, name:)
      site_navigation_element << { url: url, name: name }
    end
  end

  class Repository
    def initialize
      @items = []
    end

    def <<(item)
      @items << item
    end

    def dump
      "[" + @items.map(&:dump).join(',') + "]"
    end
  end

  class BreadcrumbList
    def initialize
      @items = []
    end

    def <<(item)
      @items << item
    end

    def empty?
      @items.empty?
    end

    def dump
      hash = {
        "@context": "http://schema.org",
        "@type": "BreadcrumbList",
      }

      hash['itemListElement'] = items_to_hash
      JSON.pretty_generate(hash)
    end

    private

    def items_to_hash
      @items.map.with_index do |item, i|
        {
          "@type": "ListItem",
          "position": i + 1,
          "item": {
            "@id": item[:url],
            "name": item[:name]
          }
        }
      end
    end
  end

  class SiteNavigationElement
    def initialize
      @urls  = []
      @names = []
    end

    def <<(item)
      @urls  << item[:url]
      @names << item[:name]

      item
    end

    def empty?
      @urls.empty? && @names.empty?
    end

    def dump
      hash = {
        "@context": "http://schema.org",
        "@type": "SiteNavigationElement",
      }

      hash[:url] = @urls
      hash[:name] = @names

      JSON.pretty_generate(hash)
    end
  end
end

ActionView::Base.send :include, StructuredData::ViewHelper
ActionController::Base.send :include, StructuredData::ControllerHelper
