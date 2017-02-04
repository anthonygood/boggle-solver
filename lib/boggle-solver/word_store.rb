module Boggle
  # Word class just pairs together a word and its indices on the board
  class Word
    attr_accessor :indices, :word

    def initialize(word, indices)
      @word = word
      @indices = indices
    end

    def inspect
      @word
    end

    def to_s
      @word
    end

    def to_h
      { word: word, indices: indices }
    end
  end

  # WordStore allows simple access to an underlying array of Word objects.
  #
  # Eg. get all words as plain strings:
  # my_store.to_s -> ["cat","dog"]
  class WordStore
    def initialize
      @words = []
    end

    def add(word, indices)
      @words.push Word.new(word, indices)
    end

    # Return an array of plain strings rather than Word objects
    def to_strings
      @words.map &:to_s
    end

    def to_a
      @words.map &:to_h
    end

    alias :to_hashes :to_a

    def [](index)
      @words[index]
    end

    def count
      @words.count
    end

    alias :length :count
  end
end
