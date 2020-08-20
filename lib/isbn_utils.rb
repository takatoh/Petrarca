require "isbn_utils/version"
require "isbn_utils/isbn13"
require "isbn_utils/isbn10"


module ISBNUtils
  class Error < StandardError; end

  extend self

  def correct_format?(isbn)
    isbn = isbn.delete("-")
    case isbn.size
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
      nil
    end
  end

end
