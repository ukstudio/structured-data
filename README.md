# StructuredData

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/8fcd07fae7064e0cae2e78aab004619f)](https://www.codacy.com/app/ukstudio/structured-data?utm_source=github.com&utm_medium=referral&utm_content=ukstudio/structured-data&utm_campaign=badger)
[![CircleCI](https://circleci.com/gh/ukstudio/structured_data/tree/master.svg?style=svg)](https://circleci.com/gh/ukstudio/structured_data/tree/master)

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

Call the helper method in Controller or View

```slim
= set_breadcrumb_item(url: '/products', name: 'Products')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ukstudio/structured_data.

