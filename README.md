# StructuredData

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'structured-data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install structured-data

## Usage

```ruby
repo = StructuredData::Repository.new

breadcrumb = StructuredData::BreadcrumbList.new
breadcrumb << { url: '/products', name: 'Products' }
breadcrumb << { url: '/products/book', name: 'Book' }

repo << breadcrumb
repo.dump
```

```json
[{
  "@context": "http://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "item": {
        "@id": "/products",
        "name": "Products"
      }
    },
    {
      "@type": "ListItem",
      "position": 2,
      "item": {
        "@id": "/products/book",
        "name": "Book"
      }
    }
  ]
}]
```

### Rails support

```ruby
# in controller or view
breadcrumb_list do
  add url: '/products', name: 'Product'
  add url: '/products/tshirts, name: 'Tshirt'
end
```

```slim
= display_structured_data
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ukstudio/structured_data.

