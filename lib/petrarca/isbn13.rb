require "petrarca/helpers"


module Petrarca
  module ISBN13

    extend self

    def valid?(isbn)
      isbn = isbn.to_s
      if correct_format?(isbn) && isbn[-1] == calc_check_digit(isbn)
        if isbn.include?("-")
          Helpers.split(isbn) == isbn.split("-")
        else
          true
        end
      else
        false
      end
    end

    def correct_format?(isbn)
      isbn = dehyphenate(isbn)
      !!(/\A97[89]\d{9}\d\z/ =~ isbn)
    end

    def calc_check_digit(isbn)
      nums = dehyphenate(isbn).split("")[0, 12].map{|x| x.to_i }
      sum = nums.zip([1, 3] * 6).map{|x, y| x * y }.inject(:+)
      check_digit = 10 - (sum % 10)
      check_digit == 10 ? "0" : check_digit.to_s
    end

    def dehyphenate(isbn)
      Petrarca.dehyphenate(isbn)
    end

    def hyphenate(isbn)
      split(isbn).join("-")
    end

    def split(isbn)
      Helpers.split(isbn)
    end

  end
end
