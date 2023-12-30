require_relative "../lib/petrarca"


RSpec.describe Petrarca do

  let(:valid_isbn13) { "978-4-8156-0644-2" }
  let(:valid_isbn13_dehyphenated) { "9784815606442"}
  let(:invalid_isbn13) { "978-4-8156-0644-0" }
  let(:invalid_isbn13_dehyphenated) { "9784815606440" }
  let(:correct_check_digit_isbn13) { "2" }

  let(:valid_isbn10) { "4-8156-0644-7" }
  let(:valid_isbn10_dehyphenated) { "4815606447"}
  let(:invalid_isbn10) { "4-8156-0644-0" }
  let(:invalid_isbn10_dehyphenated) { "4815606440" }
  let(:correct_check_digit_isbn10) { "7" }

  let(:nonsence_isbn) { "1-234-567-8" }


  describe "valid?" do
    context "isbn13" do
      it "returns true for valid isbn13" do
        expect(Petrarca.valid?(valid_isbn13)).to eq true
      end

      it "returns false for invalid isbn13" do
        expect(Petrarca.valid?(invalid_isbn13)).to eq false
      end
    end

    context "isbn10" do
      it "returns true for valid isbn10" do
        expect(Petrarca.valid?(valid_isbn10)).to eq true
      end

      it "returns false for invalid isbn10" do
        expect(Petrarca.valid?(invalid_isbn10)).to eq false
      end
    end
  end

  describe "calc_check_digit" do
    context "isbn13" do
      it "returns correct value for valid isbn13" do
        expect(Petrarca.calc_check_digit(valid_isbn13)).to eq correct_check_digit_isbn13
      end

      it "returns correct value for invalid isbn13" do
        expect(Petrarca.calc_check_digit(invalid_isbn13)).to eq correct_check_digit_isbn13
      end

      it "returns correct value for isbn13 without check digit" do
        expect(Petrarca.calc_check_digit(valid_isbn13[0..-2])).to eq correct_check_digit_isbn13
      end
    end

    context "isbn10" do
      it "returns correct value for valid isbn10" do
        expect(Petrarca.calc_check_digit(valid_isbn10)).to eq correct_check_digit_isbn10
      end

      it "returns correct value for invalid isbn10" do
        expect(Petrarca.calc_check_digit(invalid_isbn10)).to eq correct_check_digit_isbn10
      end

      it "returns correct value for isbn10 without check digit" do
        expect(Petrarca.calc_check_digit(valid_isbn10[0..-2])).to eq correct_check_digit_isbn10
      end
    end

    context "noncense isbn" do
      it "raise IncorrectFormatError for nonsence isbn" do
        expect{ Petrarca.calc_check_digit(nonsence_isbn) }.to raise_error Petrarca::IncorrectFormatError
      end
    end
  end

  describe "hyphenate" do
    context "isbn13" do
      it "returns hyphenated for valid isbn13" do
        expect(Petrarca.hyphenate(valid_isbn13_dehyphenated)).to eq valid_isbn13
      end

      it "returns hyphenated for also invalid isbn13" do
        expect(Petrarca.hyphenate(invalid_isbn13_dehyphenated)).to eq invalid_isbn13
      end
    end

    context "isbn10" do
      it "returns hyphenated for valid isbn10" do
        expect(Petrarca.hyphenate(valid_isbn10_dehyphenated)).to eq valid_isbn10
      end

      it "returns hyphenated for also invalid isbn10" do
        expect(Petrarca.hyphenate(invalid_isbn10_dehyphenated)).to eq invalid_isbn10
      end
    end
  end

  describe "dehyphenate" do
    context "isbn13" do
      it "returns dehyphenated for valid isbn13" do
        expect(Petrarca.dehyphenate(valid_isbn13)).to eq valid_isbn13_dehyphenated
      end

      it "returns dehyphenated for also invalid isbn13" do
        expect(Petrarca.dehyphenate(invalid_isbn13)).to eq invalid_isbn13_dehyphenated
      end
    end

    context "isbn10" do
      it "returns dehyphenated for valid isbn10" do
        expect(Petrarca.dehyphenate(valid_isbn10)).to eq valid_isbn10_dehyphenated
      end

      it "returns dehyphenated for also invalid isbn10" do
        expect(Petrarca.dehyphenate(invalid_isbn10)).to eq invalid_isbn10_dehyphenated
      end
    end
  end

  describe "to_10" do
    it "returns isbn10" do
      expect(Petrarca.to_10(valid_isbn13)).to eq valid_isbn10
    end
  end

  describe "to_13" do
    it "returns isbn13" do
      expect(Petrarca.to_13(valid_isbn10)).to eq valid_isbn13
    end
  end

end
