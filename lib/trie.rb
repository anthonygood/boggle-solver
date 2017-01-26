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

  def add(word)
    # `node` will describe where we are in the trie.
    # So, begin with self.
    node = self

    word.split("").each_with_index do |letter, index|

      is_last_letter = index == letter.length + 1
      letter_sym = letter.to_sym

      # If this letter doesn't exist in the trie, add it
      if node[letter_sym].nil?

        # If we've reached the last letter, mark as terminal node
        if is_last_letter
          node[letter_sym] = true

        # Otherwise, an empty hash, and build upon current node
        else
          node[letter_sym] = {}
          node = node[letter_sym]
        end
      end
    end
  end
end
