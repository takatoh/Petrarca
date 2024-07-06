# Petrarca

This library Petrarca provides some utility functions to manipulate ISBN numbers:

- Validation
- Calculate check digit
- Mutual conversion of ISBN-13 and ISBN-10
- Hyphenation / Dehyphenation
- Split to a array that includes ISBN segments

All functions support both ISBN-13 and ISBN-10.

All ranges of registration groups and registrants are supported.
Those depends on 'RangeMessage.xml' file, downloaded from [International ISBN Agency](https://www.isbn-international.org/range_file_generation).

NOTE: Updated range files to latest version on July 6, 2024.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'petrarca'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install petrarca

## Usage

    irb(main):001:0> require 'petrarca'
    => true
    irb(main):002:0> Petrarca.valid?("978-4-8156-0644-2")
    => true
    irb(main):003:0> Petrarca.calc_check_digit("978-4-8156-0644-2")
    => "2"
    irb(main):004:0> Petrarca.to_10("978-4-8156-0644-2")
    => "4-8156-0644-7"
    irb(main):005:0> Petrarca.to_13("4-8156-0644-7")
    => "978-4-8156-0644-2"
    irb(main):006:0> Petrarca.hyphenate("9784815606442")
    => "978-4-8156-0644-2"
    irb(main):007:0> Petrarca.dehyphenate("978-4-8156-0644-2")
    => "9784815605442"
    irb(main):008:0> Petrarca.split("9784815606442")
    => ["978", "4", "8156", "0644", "2"]

`Petrarca.dehyphenate` and `Petrarca.split` are new in v0.6.0.

Accept Integer as ISBN, only if no `-` and `X` including. (New in v0.5.0)

    irb(main):001:0> require 'petrarca'
    => true
    irb(main):002:0> Petrarca.calc_check_digit(978481560644)
    => "2"
    irb(main):003:0> Petrarca.to_10(9784815606442)
    => "4-8156-0644-7"
    irb(main):004:0> Petrarca.to_13(4815606447)
    => "978-4-8156-0644-2"
    irb(main):005:0> Petrarca.hyphenate(9784815606442)
    => "978-4-8156-0644-2"

If the ISBN is hyphenated, registration group and registrant are considered in `Petrarca.valid?`. The second example below has the invalid registrant.

    irb(main):006:0> Petrarca.valid?("978-4-8156-0644-2")
    => true
    irb(main):007:0> Petrarca.valid?("978-4-815-60644-2")
    => false

## License

MIT License

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/takatoh/Petrarca.
