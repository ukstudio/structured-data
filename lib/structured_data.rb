require 'json'

module StructuredData
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

require 'structured_data/rails_extentions'
