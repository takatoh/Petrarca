module ISBNUtils
  module ISBN13

    extend self

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

  end
end
