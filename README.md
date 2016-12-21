# StructuredData

[![CircleCI](https://circleci.com/gh/ukstudio/structured_data/tree/master.svg?style=svg)](https://circleci.com/gh/ukstudio/structured_data/tree/master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'structured_data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install structured_data

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

Call the helper method in Controller or View

```slim
= set_breadcrumb_item(url: '/products', name: 'Products')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ukstudio/structured_data.

