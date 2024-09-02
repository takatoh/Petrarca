require "petrarca/version"
require "petrarca/isbn13"
require "petrarca/isbn10"
require "petrarca/helpers"
require "isbnranges"


module Petrarca
  class Error < StandardError; end
  class IncorrectFormatError < StandardError; end

  REGISTRATION_GROUP_RANGES = ISBNRanges::REGISTRATION_GROUP_RANGES
  REGISTRANT_RANGES = ISBNRanges::REGISTRANT_RANGES

  extend self

  def valid?(isbn)
    case dehyphenate(isbn).size
    when 13
      ISBN13.valid?(isbn)
    when 10
      ISBN10.valid?(isbn)
    else
      false
    end
  end

  def correct_format?(isbn)
    case dehyphenate(isbn).size
    when 13
      ISBN13.correct_format?(isbn)
    when 10
      ISBN10.correct_format?(isbn)
    else
      false
    end
  end

  def calc_check_digit(isbn)
    isbn = dehyphenate(isbn)
    case isbn.size
    when 12, 13
      ISBN13.calc_check_digit(isbn)
    when 9, 10
      ISBN10.calc_check_digit(isbn)
    else
      raise IncorrectFormatError
    end
  end

  def dehyphenate(isbn)
    isbn.to_s.delete("-")
  end

  def hyphenate(isbn)
    isbn = isbn.to_s
    case isbn.size
    when 13
      ISBN13.hyphenate(isbn)
    when 10
      ISBN10.hyphenate(isbn)
    end
  end

  def split(isbn)
    isbn = isbn.to_s
    case isbn.size
    when 13
      ISBN13.split(isbn)
    when 10
      ISBN10.split(isbn)
    end
  end

  def to_10(isbn13)
    s = dehyphenate(isbn13)[3, 9]
    ISBN10.hyphenate(s + ISBN10.calc_check_digit(s))
  end

  def to_13(isbn10)
    s = "978" + dehyphenate(isbn10)[0, 9]
    ISBN13.hyphenate(s + ISBN13.calc_check_digit(s))
  end

end
