require "isbn_utils/helpers"


module ISBNUtils
  module ISBN13

    include Helpers

    extend self

    def valid?(isbn)
      correct_format?(isbn) && isbn[-1] == calc_check_digit(isbn)
    end

    def correct_format?(isbn)
      isbn = isbn.delete("-")
      !!(/\A97[89]\d{9}\d\z/ =~ isbn)
    end

    def calc_check_digit(isbn)
      nums = isbn.delete("-").split("")[0..11].map{|x| x.to_i }
      sum = nums.zip([1, 3] * 6).map{|x, y| x * y }.inject(:+)
      check_digit = 10 - (sum % 10)
      check_digit == 10 ? "0" : check_digit.to_s
    end

    def hyphenate(isbn)
      ean_prefix = isbn[0..2]
      body = isbn[3..11]
      check_digit = isbn[12..12]
      registration_group, body = split_to_parts(body, RegistrationGroupRanges[ean_prefix])
      prefix = "#{ean_prefix}-#{registration_group}"
      registrant, publication = split_to_parts(body, RegistrantRanges[prefix])
      [ean_prefix, registration_group, registrant, publication, check_digit].join("-")
    end

  end
end
