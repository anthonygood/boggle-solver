require_relative "../lib/trie"

describe Trie do
  let(:trie) { described_class.new }

  it "can add words" do
    trie.add("cat")
    expect(trie).to eql c: {a: {t: true}}
  end
end
