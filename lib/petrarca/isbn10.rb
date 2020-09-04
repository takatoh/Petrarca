require "petrarca/helpers"


module Petrarca
  module ISBN10

    extend self

    def valid?(isbn)
      correct_format?(isbn) && isbn[-1] == calc_check_digit(isbn)
    end

    def correct_format?(isbn)
      isbn = isbn.delete("-")
      !!(/\A\d{9}[0-9X]\z/ =~ isbn)
    end

    def calc_check_digit(isbn)
      nums = isbn.delete("-").split("")[0..8].map{|x| x.to_i }
      sum = nums.zip((2..10).to_a.reverse).map{|x, y| x * y }.inject(:+)
      check_digit = 11 - (sum % 11)
      case check_digit
      when 10
        "X"
      when 11
        "0"
      else
        check_digit.to_s
      end
    end

    def hyphenate(isbn)
      s = ISBN13.hyphenate("978" + isbn)
      s.sub(/^978-/, "")
    end

  end
end
