require "isbn_utils/version"
require "isbn_utils/isbn13"
require "isbn_utils/isbn10"
require "isbn_utils/helpers"


module ISBNUtils
  class Error < StandardError; end
  class IncorrectFormatError < StandardError; end

  data_dir = __dir__ + "/../data"
  REGISTRATION_GROUP_RANGES = Helpers.load_ranges("#{data_dir}/registration_group_ranges.txt")
  REGISTRANT_RANGES = Helpers.load_ranges("#{data_dir}/registrant_ranges.txt")

  extend self

  def valid?(isbn)
    case isbn.delete("-").size
    when 13
      ISBN13.valid?(isbn)
    when 10
      ISBN10.valid?(isbn)
    else
      false
    end
  end

  def correct_format?(isbn)
    case isbn.delete("-").size
    when 13
      ISBN13.correct_format?(isbn)
    when 10
      ISBN10.correct_format?(isbn)
    else
      false
    end
  end

  def calc_check_digit(isbn)
    isbn = isbn.delete("-")
    case isbn.size
    when 12, 13
      ISBN13.calc_check_digit(isbn)
    when 9, 10
      ISBN10.calc_check_digit(isbn)
    else
      raise IncorrectFormatError
    end
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

  def to_10(isbn13)
    s = isbn13.to_s.delete("-")[3..11]
    ISBN10.hyphenate(s + ISBN10.calc_check_digit(s))
  end

  def to_13(isbn10)
    s = "978" + isbn10.to_s.delete("-")[0..8]
    ISBN13.hyphenate(s + ISBN13.calc_check_digit(s))
  end

end
