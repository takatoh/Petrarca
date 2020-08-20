module ISBNUtils
  module ISBN13

    extend self

    def correct_format?(isbn)
      isbn = isbn.delete("-")
      !!(/\A97[89]\d{9}\d\z/ =~ isbn)
    end
  end
end
