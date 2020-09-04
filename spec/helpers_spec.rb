require_relative "../lib/petrarca"


include Petrarca::Helpers

RSpec.describe Petrarca::Helpers do

  describe "split_to_parts" do
    it "returns a Array include prefix and body" do
      expect(split_to_parts("4815606442", Petrarca::REGISTRATION_GROUP_RANGES["978"])).to eq ["4", "815606442"]    end
  end

end
