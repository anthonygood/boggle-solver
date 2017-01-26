# A Trie is essentially a nested hash which represents word roots
# (and indeed full words). Something like:
#
# {c: {a: {t: {valid: true}}}}
#                     where {valid: true} marks a terminal node.
# A trie is a good solution for finding words and word roots quickly.
# Whereas an array will have quicker writes, a trie will have quicker reads.
#
#
class Trie < Hash
  def initialize(*args)
    super nil # ignore hash options
    args.each {|word| add word }
  end

  def add(word)
    each_node(word) do |node, letter, is_last|

      # If the letter doesn't occur in the current node, add it.
      node[letter] = {} if node[letter].nil?

      # If we've reached the last letter, mark as terminal node and return.
      return node[letter][:valid] = true if is_last
    end
  end

  def is_word?(word)
    each_node(word) do |node, letter, is_last|
      return false if node[letter].nil?
      return true if is_last && node[letter][:valid]
    end

    false
  end

  def is_prefix?(prefix)
    each_node(prefix) do |node, letter, is_last|
      return false if node[letter].nil?

      # At the last letter, see if the node has any keys apart from :valid,
      # which indicates a terminal node of a word.
      if is_last
        keys = node[letter].keys
        further_nodes = (keys - [:valid]).length

        return false unless further_nodes > 0
      end
    end

    true
  end

  private

  # Iterates through each letter of a word.
  # Yields the current node of the trie, the letter (as symbol), and true or false whether this is the last letter.
  def each_node(word, &block)
    # `node` will describe where we are in the trie.
    # So, begin with the root node: self.
    node = self

    word.split("").each_with_index do |letter, index|
      is_last_letter = index == word.length - 1

      yield node, letter.to_sym, is_last_letter

      # Traverse to next node.
      node = node[letter.to_sym]
    end
  end
end
