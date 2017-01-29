require "boggle-solver/trie"

describe Boggle::Trie do
  let(:trie) { described_class.new }

  it "can add words" do
    trie.add "cat"
    expect(trie).to eql c: {a: {t: {valid: true}}}
  end

  it "can have multiple words" do
    trie.add "man"
    trie.add "wo"

    expect(trie).to eql({
      m: {a: {n: {valid: true}}},
      w: {o: {valid: true}}
    })
  end

  it "can have words with the same roots" do
    trie.add "cat"
    trie.add "car"

    expect(trie).to eql({
      c: {a: {
        t: {valid: true},
        r: {valid: true}
      }}
    })
  end

  it "can have words of different lengths with the same root" do
    trie.add "ab"
    trie.add "abs"

    expect(trie).to eql({
      a: {b: {
        valid: true,
        s: {valid: true}
        }
      }
    })

    other_trie = described_class.new
    other_trie.add "cat"
    other_trie.add "ca"

    expect(other_trie).to eql({
      c: {a: {
        valid: true,
        t: {valid: true}
        }}
    })
  end

  describe "querying" do
    before { trie.add("cat") }

    it "can be queried for words" do
      expect(trie.is_word?("cat")).to be true
      expect(trie.is_word?("ca")).to be false
    end

    it "can be queried for prefixes" do
      expect(trie.is_prefix?("cat")).to be false
      expect(trie.is_prefix?("ca")).to be true
    end
  end

  it "can be built from words passed to constructor" do
    trie = described_class.new("cat", "ca")

    expect(trie).to eql({
      c: {a: {
        valid: true,
        t: {valid: true}
        }}
    })
  end
end
