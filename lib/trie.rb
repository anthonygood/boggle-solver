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

      # Return the next node to traverse to.
      node[letter]
    end
  end

  # Iterates through each letter of a word.
  # Yields the current node, the letter (as symbol), and true or false whether this is the last letter.
  # The return value of the passed block determines the next node.
  def each_node(word, &block)
    # `node` will describe where we are in the trie.
    # So, begin with the root node: self.
    node = self

    word.split("").each_with_index do |letter, index|
      is_last_letter = index == word.length - 1

      node = block.call node, letter.to_sym, is_last_letter
    end
  end

  def is_word?(word)
    node = self

    each_letter(word) do |letter, is_last|
      return false if node[letter.to_sym].nil?

      if is_last
        return false unless node[letter.to_sym][:valid]
      end

      node = node[letter.to_sym]
    end

    true
  end

  def is_prefix?(prefix)
    node = self

    each_letter(prefix) do |letter, is_last|
      return false if node[letter.to_sym].nil?

      if is_last
        # See if this node has any keys apart from :valid,
        # which indicates terminal node of word.
        keys = node[letter.to_sym].keys
        return false unless (keys - [:valid]).length > 0
      end

      node = node[letter.to_sym]
    end

    true
  end

  def each_letter(word, &block)
    word.split("").each_with_index do |letter, index|
      is_last_letter = index == word.length - 1
      yield letter, is_last_letter
    end
  end
end
