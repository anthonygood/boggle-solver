require "boggle-solver/version"
require "boggle-solver/word_store"
require "boggle-solver/loaded_trie"

module Boggle
  class Solver
    attr_accessor :letters, :grid, :sqrt, :found_words

    def self.solve(letters)
      new(letters).solve_grid
    end

    # Factory method for directly returning word store object after solving
    def self.words_in(letters)
      solve(letters).found_words
    end

    # Pass load: true to load trie from dictionary upon instantiation
    def initialize(letters, load:false)
      validate(letters)

          @letters = letters.downcase
             @sqrt = Math.sqrt(@letters.length).to_i
             @grid = letters_to_grid
      @found_words = Boggle::WordStore.new
             @trie = Boggle::LoadedTrie
    end

    def solve_grid
      for_each_letter {|letter, i, j| solve "", i, j }
      self
    end

    def solve(word, row_index, letter_index, indices=[])
      letter      = grid[row_index][letter_index]

      new_word    = word + letter
      new_indices = indices + [[row_index, letter_index]]

      if is_word?(new_word)
        found_words.add new_word, new_indices
      end

      # check if current word is a valid word root
      # if words_containing(new_word).any?
      if is_prefix?(new_word)
        each_adjacent_letter(row_index, letter_index) do |letter, i, j|
          if !new_indices.include? [i, j]
            solve new_word, i, j, new_indices
          end
        end
      end
    end

    def for_each_letter(&block)
      grid.each_with_index do |row, i|
        row.each_with_index do |letter, j|
          yield letter, i, j
        end
      end
    end

    private

    def validate(lttrs)
      # Invalid unless square number of letters.
      unless Math.sqrt(lttrs.length).to_i == Math.sqrt(lttrs.length)
        raise ArgumentError, "The letters passed do not represent a square grid (#{lttrs})"
      end
    end

    def letters_to_grid
      letters.scan(/.{#{sqrt}}/).map {|str| str.split("") }
    end

    def each_adjacent_letter(i, j, &block)
      (i-1..i+1).each do |row_i|
        # skip if no row exists
        next if row_i < 0 || row_i > grid.size - 1

        row = grid[row_i]

        (j-1..j+1).each do |letter_i|
          # skip if no letter exist in row

          next if letter_i < 0 || letter_i > row.size
          # skip if this is the selfsame letter
          next if i == row_i && j == letter_i

          # skip if out of bounds
          next unless letter = row[letter_i]

          # all is well, yield letter
          yield letter, row_i, letter_i
        end
      end
    end

    def is_word?(word)
      @trie.is_word? word
    end

    def is_prefix?(word)
      @trie.is_prefix? word
    end
  end
end
