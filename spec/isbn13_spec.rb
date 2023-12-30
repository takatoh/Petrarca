require_relative "../lib/petrarca"


RSpec.describe Petrarca::ISBN13 do

  let(:valid_isbn13) { "978-4-8156-0644-2" }
  let(:valid_isbn13_dehyphenated) { "9784815606442" }
  let(:invalid_isbn13) { "978-4-8156-0644-0" }
  let(:invalid_isbn13_dehyphenated) { "9784815606440" }
  let(:correct_check_digit) { "2" }
  let(:splited_isbn13) { ["978", "4", "8156", "0644", "2"] }

  describe "valid?" do
    it "returns true for valid isbn13" do
      expect(Petrarca::ISBN13.valid?(valid_isbn13)).to eq true
    end

    it "returns false for invalid isbn13" do
      expect(Petrarca::ISBN13.valid?(invalid_isbn13)).to eq false
    end
  end

  describe "calc_check_digit" do
    it "returns correct value for valid isbn13" do
      expect(Petrarca::ISBN13.calc_check_digit(valid_isbn13)).to eq correct_check_digit
    end

    it "returns correct value for invalid isbn13" do
      expect(Petrarca::ISBN13.calc_check_digit(invalid_isbn13)).to eq correct_check_digit
    end

    it "returns correct value for isbn13 without check digit" do
      expect(Petrarca::ISBN13.calc_check_digit(valid_isbn13[0..-2])).to eq correct_check_digit
    end
  end

  describe "hyphenate" do
    it "returns hyphenated for valid isbn13" do
      expect(Petrarca::ISBN13.hyphenate(valid_isbn13_dehyphenated)).to eq valid_isbn13
    end

    it "returns hyphenated for also invalid isbn13" do
      expect(Petrarca::ISBN13.hyphenate(invalid_isbn13_dehyphenated)).to eq invalid_isbn13
    end
  end

  describe "dehyphenate" do
    it "returns dehyphenated for valid isbn13" do
      expect(Petrarca::ISBN10.dehyphenate(valid_isbn13)).to eq valid_isbn13_dehyphenated
    end

    it "returns dehyphenated for also invalid isbn13" do
      expect(Petrarca::ISBN10.dehyphenate(invalid_isbn13)).to eq invalid_isbn13_dehyphenated
    end
  end

  describe "split" do
    it "returns a array that splited isbn13 to" do
      expect(Petrarca::ISBN13.split(valid_isbn13_dehyphenated)).to eq splited_isbn13
    end
  end

end
