require_relative "trie"
require_relative "words"

# Loading a trie with thousands of words is expensive.
# LoadedTrie provides access to a Trie singleton.
class LoadedTrie
  class << self
    def is_word?(word)
      trie.is_word? word
    end

    def is_prefix?(prefix)
      trie.is_prefix? prefix
    end

    private

    def trie
      @trie ||= Trie.new.tap do |instance|
        print "\nLoading trie..."
        WORDS.each {|word| instance.add word }
        print "done!\n"
      end
    end
  end
end
