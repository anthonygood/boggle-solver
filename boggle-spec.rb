require_relative "boggle"

describe Boggle do
  let(:simple_grid) { "CABT" }
  let(:bigger_grid) { "THACKREAS"}
  let(:boggle) { described_class.new(simple_grid) }

  context "with invalid (non-square) number of letters" do
    it "raises ArgumentError" do
      expect { Boggle.new("ABC") }.to raise_error(ArgumentError)
    end
  end

  it "solves a simple grid", :focus do
    solution = Boggle.solve(simple_grid)

    expect(solution).to eql ["cab", "cat", "act", "ab", "at", "ba", "bat", "ta", "tab"]
  end

  it "solves a bigger grid", :focus do
    solution = Boggle.solve(bigger_grid)

    expect(solution.length).to eql 76
  end

  describe "is_word?" do
    it "is false for non-word" do
      expect(boggle.send(:is_word?, "afdgsdfgs")).to be false
    end

    it "is false for partial word" do
      expect(boggle.send(:is_word?, "ough")).to be false
    end

    it "is true for word" do
      expect(boggle.send(:is_word?, "cat")).to be true
    end
  end

  describe "each_adjacent_letter" do
    it "yields every adjacent letter" do
      letters = []
      boggle.each_adjacent_letter(0,0) do |letter|
        letters.push letter
      end

      expect(letters).to eql ["a","b","t"]
    end
  end
end
