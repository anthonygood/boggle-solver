# A Trie is essentially a nested hash which represents word roots
# (and indeed full words). Something like:
#
# {c: {a: {t: true}}}
#                     where 'true' marks a terminal node.
# A trie is a good solution for finding words and word roots quickly.
# Whereas an array will have quicker writes, a trie will have quicker reads.
require "pry-byebug"

class Trie < Hash
  def initialize(options={})
    super nil # ignore hash options
  end

  def debug
    @debug = true
  end

  def add(word)
    # `node` will describe where we are in the trie.
    # So, begin with the root node: self.
    node = self

    word.split("").each_with_index do |letter, index|

      is_last_letter = index == word.length - 1

      binding.pry if @debug

      # If this letter doesn't exist in the trie, add it
      if node[letter.to_sym].nil?

        # If we've reached the last letter, mark as terminal node
        # Otherwise, an empty hash, and build upon current node
        node[letter.to_sym] = is_last_letter ? {valid: true} : {}
      end

      # Traverse to the next node
      node = node[letter.to_sym]
    end
  end
end
