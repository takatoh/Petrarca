# ISBNUtils

This library provides some utility functions for ISBN:

- Validation
- Calculate check digit
- Mutual conversion of ISBN13 and ISBN10
- Hyphenation

All functions support both ISBN13 and ISBN10.

Note: Only registrant ranges for Japan are currently supported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'isbn_utils'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install isbn_utils

## Usage

    irb(main):001:0> require 'isbn_utils'
    => true
    irb(main):002:0> ISBNUtils.valid?("978-4-8156-0644-2")
    => true
    irb(main):003:0> ISBNUtils.calc_check_digit("978-4-8156-0644-2")
    => "2"
    irb(main):004:0> ISBNUtils.to_10("978-4-8156-0644-2")
    => "4-8156-0644-7"
    irb(main):005:0> ISBNUtils.to_13("4-8156-0644-7")
    => "978-4-8156-0644-2"
    irb(main):006:0> ISBNUtils.hyphenate("9784815606442")
    => "978-4-8156-0644-2"

## License

MIT License

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/takatoh/isbn_utils.
