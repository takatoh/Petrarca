require_relative "../lib/isbn_utils"


RSpec.describe ISBNUtils do

  let(:valid_isbn13) { "978-4-8156-0644-2" }
  let(:invalid_isbn13) { "978-4-8156-0644-0" }
  let(:correct_check_digit_isbn13) { "2" }
  let(:valid_isbn10) { "4-8156-0644-7" }
  let(:invalid_isbn10) { "4-8156-0644-0" }
  let(:correct_check_digit_isbn10) { "7" }
  let(:nonsence_isbn) { "1-234-567-8" }

  describe "valid?" do
    context "isbn13" do
      it "returns true for valid isbn13" do
        expect(ISBNUtils.valid?(valid_isbn13)).to eq true
      end

      it "returns false for invalid isbn13" do
        expect(ISBNUtils.valid?(invalid_isbn13)).to eq false
      end
    end

    context "isbn10" do
      it "returns true for valid isbn10" do
        expect(ISBNUtils.valid?(valid_isbn10)).to eq true
      end

      it "returns false for invalid isbn10" do
        expect(ISBNUtils.valid?(invalid_isbn10)).to eq false
      end
    end
  end

  describe "calc_check_digit" do
    context "isbn13" do
      it "returns correct value for valid isbn13" do
        expect(ISBNUtils.calc_check_digit(valid_isbn13)).to eq correct_check_digit_isbn13
      end

      it "returns correct value for invalid isbn13" do
        expect(ISBNUtils.calc_check_digit(invalid_isbn13)).to eq correct_check_digit_isbn13
      end

      it "returns correct value for isbn13 without check digit" do
        expect(ISBNUtils.calc_check_digit(valid_isbn13[0..-2])).to eq correct_check_digit_isbn13
      end
    end

    context "isbn10" do
      it "returns correct value for valid isbn10" do
        expect(ISBNUtils.calc_check_digit(valid_isbn10)).to eq correct_check_digit_isbn10
      end

      it "returns correct value for invalid isbn10" do
        expect(ISBNUtils.calc_check_digit(invalid_isbn10)).to eq correct_check_digit_isbn10
      end

      it "returns correct value for isbn10 without check digit" do
        expect(ISBNUtils.calc_check_digit(valid_isbn10[0..-2])).to eq correct_check_digit_isbn10
      end
    end

    context "noncense isbn" do
      it "raise IncorrectFormatError for nonsence isbn" do
        expect{ ISBNUtils.calc_check_digit(nonsence_isbn) }.to raise_error ISBNUtils::IncorrectFormatError
      end
    end
  end

  describe "retruns hyphenated isbn" do
    context "isbn13" do
      it "returns hyphenated for valid isbn13" do
        expect(ISBNUtils.hyphenate(valid_isbn13.delete("-"))).to eq valid_isbn13
      end

      it "returns hyphenated for also invalid isbn13" do
        expect(ISBNUtils.hyphenate(invalid_isbn13.delete("-"))).to eq invalid_isbn13
      end
    end

    context "isbn10" do
      it "returns hyphenated for valid isbn10" do
        expect(ISBNUtils.hyphenate(valid_isbn10.delete("-"))).to eq valid_isbn10
      end

      it "returns hyphenated for also invalid isbn10" do
        expect(ISBNUtils.hyphenate(invalid_isbn10.delete("-"))).to eq invalid_isbn10
      end
    end
  end

end