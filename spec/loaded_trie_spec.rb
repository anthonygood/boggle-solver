require "boggle-solver/loaded_trie"

describe Boggle::LoadedTrie do
  it "only loads a single trie" do
    expect(described_class.is_word?("caterwauling")).to be true

    expect(Boggle::Trie).not_to receive(:new)

    expect(described_class.is_prefix?("prefix")).to be true
    expect(described_class.is_word?("caterwaulin")).to be false
    expect(described_class.is_prefix?("preff")).to be false
  end
end
