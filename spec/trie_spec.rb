require_relative "../lib/trie"

describe Trie do
  let(:trie) { described_class.new }

  it "can add words" do
    trie.add("cat")
    expect(trie).to eql c: {a: {t: true}}
  end

  it "can have multiple words" do
    trie.add("man")
    trie.add("wo")

    expect(trie).to eql({
      m: {a: {n: true}},
      w: {o: true}
    })
  end

  it "can have words with the same roots" do
    trie.add("cat")
    trie.add("car")

    expect(trie).to eql({
      c: {a: {
        t: true,
        r: true
      }}
    })
  end
end
