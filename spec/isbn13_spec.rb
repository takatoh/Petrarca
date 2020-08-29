require_relative "../lib/isbn_utils"


RSpec.describe ISBNUtils::ISBN13 do

  let(:valid_isbn13) { "978-4-8156-0644-2" }
  let(:invalid_isbn13) { "978-4-8156-0644-0" }
  let(:correct_check_digit) { "2" }

  describe "valid?" do
    it "returns true for valid isbn13" do
      expect(ISBNUtils::ISBN13.valid?(valid_isbn13)).to eq true
    end

    it "returns false for invalid isbn13" do
      expect(ISBNUtils::ISBN13.valid?(invalid_isbn13)).to eq false
    end
  end

  describe "calc_check_digit" do
    it "returns correct value for valid isbn13" do
      expect(ISBNUtils::ISBN13.calc_check_digit(valid_isbn13)).to eq correct_check_digit
    end

    it "returns correct value for invalid isbn13" do
      expect(ISBNUtils::ISBN13.calc_check_digit(invalid_isbn13)).to eq correct_check_digit
    end

    it "returns correct value for isbn13 without check digit" do
      expect(ISBNUtils::ISBN13.calc_check_digit(valid_isbn13[0..-2])).to eq correct_check_digit
    end
  end

  describe "hyphenate" do
    it "returns hyphenated for valid isbn13" do
      expect(ISBNUtils::ISBN13.hyphenate(valid_isbn13.delete("-"))).to eq valid_isbn13
    end

    it "returns hyphenated for also invalid isbn13" do
      expect(ISBNUtils::ISBN13.hyphenate(invalid_isbn13.delete("-"))).to eq invalid_isbn13
    end
  end

end
