require "boggle-solver"
require "pry-byebug"

describe Boggle::Solver do
  let(:simple_grid)  { "CABT" }
  let(:bigger_grid)  { "THACKREAS" }
  let(:biggest_grid) { "VCATSENYTILAAIRT" }
  let(:boggle)       { described_class.new(simple_grid) }

  before :all do
    # Cache solution across multiple examples to prevent reloading trie
    @solution = described_class.find_words!("CABT")
  end

  context "with invalid (non-square) number of letters" do
    it "raises ArgumentError" do
      expect { described_class.new("ABC") }.to raise_error(ArgumentError)
    end
  end

  describe "solving" do
    it "solves a simple grid" do
      expect(@solution.to_strings).to eql ["cab", "cat", "act", "ab", "at", "ba", "bat", "ta", "tab"]
    end

    it "returns a queryable word store" do
      expect(@solution[0]).to be_a Boggle::Word
    end

    it "solves a more complex grid" do
      expect(described_class.find_words!(bigger_grid).to_strings.length).to eq 76
    end

    it "solves en even more complex grid" do
      expect(described_class.find_words!(biggest_grid).to_strings.length).to eq 413
    end
  end
end
