require_relative "../lib/petrarca"


RSpec.describe Petrarca::ISBN10 do

  let(:valid_isbn10) { "4-8156-0644-7" }
  let(:valid_isbn10_dehyphenated) { "4815606447" }
  let(:invalid_isbn10) { "4-8156-0644-0" }
  let(:invalid_isbn10_dehyphenated) { "4815606440" }
  let(:correct_check_digit) { "7" }

  describe "valid?" do
    it "returns true for valid isbn10" do
      expect(Petrarca::ISBN10.valid?(valid_isbn10)).to eq true
    end

    it "returns false for invalid isbn10" do
      expect(Petrarca::ISBN10.valid?(invalid_isbn10)).to eq false
    end
  end

  describe "calc_check_digit" do
    it "returns correct value for valid isbn10" do
      expect(Petrarca::ISBN10.calc_check_digit(valid_isbn10)).to eq correct_check_digit
    end

    it "returns correct value for invalid isbn10" do
      expect(Petrarca::ISBN10.calc_check_digit(invalid_isbn10)).to eq correct_check_digit
    end

    it "returns correct value for isbn10 without check digit" do
      expect(Petrarca::ISBN10.calc_check_digit(valid_isbn10[0..-2])).to eq correct_check_digit
    end
  end

  describe "hyphenate" do
    it "returns hyphenated for valid isbn10" do
      expect(Petrarca::ISBN10.hyphenate(valid_isbn10_dehyphenated)).to eq valid_isbn10
    end

    it "returns hyphenated for also invalid isbn10" do
      expect(Petrarca::ISBN10.hyphenate(invalid_isbn10_dehyphenated)).to eq invalid_isbn10
    end
  end

  describe "dehyphenate" do
    it "returns dehyphenated for valid isbn10" do
      expect(Petrarca::ISBN10.dehyphenate(valid_isbn10)).to eq valid_isbn10_dehyphenated
    end

    it "returns hyphenated for also invalid isbn10" do
      expect(Petrarca::ISBN10.dehyphenate(invalid_isbn10)).to eq invalid_isbn10_dehyphenated
    end
  end

end
