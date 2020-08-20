require "isbn_utils/version"

module ISBNUtils
  class Error < StandardError; end

  extend self

  def correct_format?(isbn)
    isbn = isbn.delete("-")
    case isbn.size
    when 13
      !!(/\A97[89]\d{9}\d\z/ =~ isbn)
    when 10
      !!(/\A\d{9}[0-9X]\z/ =~ isbn)
    else
      false
    end
  end
end
