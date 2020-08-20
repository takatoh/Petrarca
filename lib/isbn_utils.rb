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
end
