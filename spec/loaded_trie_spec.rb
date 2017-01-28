require_relative "../lib/loaded_trie"

describe LoadedTrie do
  it "only loads a single trie" do
    expect(Trie).to receive(:new).once.and_call_original

    expect(LoadedTrie.is_word?("caterwauling")).to be true
    expect(LoadedTrie.is_prefix?("prefix")).to be true

    expect(LoadedTrie.is_word?("caterwaulin")).to be false
    expect(LoadedTrie.is_prefix?("preff")).to be false
  end
end
