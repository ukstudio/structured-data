require 'spec_helper'
require 'json'

RSpec.describe StructuredData::Repository do
  specify do
    repo = described_class.new

    list = StructuredData::BreadcrumbList.new
    list << { url: '/products', name: 'Products' }
    list << { url: '/products/book', name: 'Book' }

    repo << list

    element = StructuredData::SiteNavigationElement.new
    element << { url: '/products', name: 'Products' }
    element << { url: '/FAQ', name: 'FAQ' }

    repo << element

    parsed = JSON.parse(repo.dump)

    expect(parsed.size).to eq 2
  end
end

RSpec.describe StructuredData::BreadcrumbList do
  specify do
    list = described_class.new
    list << { url: '/products', name: 'Products' }
    list << { url: '/products/book', name: 'Book' }

    parsed = JSON.parse(list.dump)

    expect(parsed['@context']).to eq 'http://schema.org'
    expect(parsed['itemListElement'][0]['item']['@id']).to eq '/products'
 end
end

RSpec.describe StructuredData::SiteNavigationElement do
  specify do
    element = described_class.new
    element << { url: '/products', name: 'Products' }
    element << { url: '/FAQ', name: 'FAQ' }

    parsed = JSON.parse(element.dump)

    expect(parsed['@context']).to eq 'http://schema.org'
    expect(parsed['url'][0]).to eq "/products"
    expect(parsed['name'][0]).to eq "Products"
  end
end
