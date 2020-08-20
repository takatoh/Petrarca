require "isbn_utils/version"
require "isbn_utils/isbn13"
require "isbn_utils/isbn10"


module ISBNUtils
  class Error < StandardError; end
  class IncorrectFormatError < StandardError; end

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

end
