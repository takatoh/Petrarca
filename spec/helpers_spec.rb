require_relative "../lib/petrarca"


include Petrarca::Helpers

RSpec.describe Petrarca::Helpers do

  let(:isbn13) { "9784815606442" }
  let(:isbn13_hyphenated) { "978-4-8156-0644-2" }

  describe "split_to_parts" do
    it "returns a Array include prefix and body" do
      expect(split_to_parts(isbn13.sub(/^978/, ""), Petrarca::REGISTRATION_GROUP_RANGES["978"])).to eq ["4", "815606442"]
    end
  end

  describe "hyphenate13" do
    it "returns hyphenated isbn13" do
      expect(hyphenate13(isbn13)).to eq isbn13_hyphenated
    end
  end

end
