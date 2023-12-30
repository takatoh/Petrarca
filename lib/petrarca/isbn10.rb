require "petrarca/helpers"


module Petrarca
  module ISBN10

    extend self

    def valid?(isbn)
      isbn = isbn.to_s
      if correct_format?(isbn) && isbn[-1] == calc_check_digit(isbn)
        if isbn.include?("-")
          Helpers.split("978" + isbn).drop(1) == isbn.split("-")
        else
          true
        end
      else
        false
      end
    end

    def correct_format?(isbn)
      isbn = dehyphenate(isbn)
      !!(/\A\d{9}[0-9X]\z/ =~ isbn)
    end

    def calc_check_digit(isbn)
      nums = dehyphenate(isbn).split("")[0, 9].map{|x| x.to_i }
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
    
    def dehyphenate(isbn)
      Petrarca.dehyphenate(isbn)
    end

    def hyphenate(isbn)
      split(isbn).join("-")
    end

    def split(isbn)
      Helpers.split("978" + isbn.to_s).drop(1)
    end

  end
end
