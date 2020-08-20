module ISBNUtils
  module ISBN10

    extend self

    def correct_format?(isbn)
      isbn = isbn.delete("-")
      !!(/\A\d{9}[0-9X]\z/ =~ isbn)
    end
  end
end
