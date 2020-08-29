require_relative "../lib/isbn_utils"


RSpec.describe ISBNUtils::ISBN10 do

  let(:valid_isbn10) { "4-8156-0644-7" }
  let(:invalid_isbn10) { "4-8156-0644-0" }
  let(:correct_check_digit) { "7" }

  describe "valid?" do
    it "returns true for valid isbn10" do
      expect(ISBNUtils::ISBN10.valid?(valid_isbn10)).to eq true
    end

    it "returns false for invalid isbn10" do
      expect(ISBNUtils::ISBN10.valid?(invalid_isbn10)).to eq false
    end
  end

  describe "calc_check_digit" do
    it "returns correct value for valid isbn10" do
      expect(ISBNUtils::ISBN10.calc_check_digit(valid_isbn10)).to eq correct_check_digit
    end

    it "returns correct value for invalid isbn10" do
      expect(ISBNUtils::ISBN10.calc_check_digit(invalid_isbn10)).to eq correct_check_digit
    end

    it "returns correct value for isbn10 without check digit" do
      expect(ISBNUtils::ISBN10.calc_check_digit(valid_isbn10[0..-2])).to eq correct_check_digit
    end
  end

  describe "hyphenate" do
    it "returns hyphenated for valid isbn10" do
      expect(ISBNUtils::ISBN10.hyphenate(valid_isbn10.delete("-"))).to eq valid_isbn10
    end

    it "returns hyphenated for also invalid isbn10" do
      expect(ISBNUtils::ISBN10.hyphenate(invalid_isbn10.delete("-"))).to eq invalid_isbn10
    end
  end

end
