require "petrarca/helpers"


module Petrarca
  module ISBN13

    extend self

    def valid?(isbn)
      correct_format?(isbn) && isbn[-1] == calc_check_digit(isbn)
    end

    def correct_format?(isbn)
      isbn = isbn.to_s.delete("-")
      !!(/\A97[89]\d{9}\d\z/ =~ isbn)
    end

    def calc_check_digit(isbn)
      nums = isbn.to_s.delete("-").split("")[0, 12].map{|x| x.to_i }
      sum = nums.zip([1, 3] * 6).map{|x, y| x * y }.inject(:+)
      check_digit = 10 - (sum % 10)
      check_digit == 10 ? "0" : check_digit.to_s
    end

    def hyphenate(isbn)
      split(isbn).join("-")
    end

    private def split(isbn)
      isbn = isbn.to_s
      ean_prefix = isbn[0, 3]
      body = isbn[3, 9]
      check_digit = isbn[12, 1]
      registration_group, body = Helpers.split_to_parts(body, REGISTRATION_GROUP_RANGES[ean_prefix])
      prefix = "#{ean_prefix}-#{registration_group}"
      registrant, publication = Helpers.split_to_parts(body, REGISTRANT_RANGES[prefix])
      [ean_prefix, registration_group, registrant, publication, check_digit]
    end

  end
end
