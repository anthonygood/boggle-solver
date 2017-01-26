require_relative "../lib/trie"

describe Trie do
  let(:trie) { described_class.new }

  it "can add words" do
    trie.add("cat")
    expect(trie).to eql c: {a: {t: {valid: true}}}
  end

  xit "can have multiple words" do
    trie.add("man")
    trie.add("wo")

    expect(trie).to eql({
      m: {a: {n: {valid: true}}},
      w: {o: {valid: true}}
    })
  end

  it "can have words with the same roots" do
    trie.add("cat")
    trie.add("car")

    expect(trie).to eql({
      c: {a: {
        t: {valid: true},
        r: {valid: true}
      }}
    })
  end

  it "can have words of different lengths with the same root" do
    trie.add("ab")
    # trie.debug
    trie.add("abs")

    expect(trie).to eql({
      a: {b: {
        valid: true,
        s: {valid: true}
        }
      }
    })
  end

  xit "can be queried" do
    trie.add("cat")
    expect(trie.is_word?("cat"))
  end
end
