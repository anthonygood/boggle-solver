require_relative "words"
require_relative "word_store"
require_relative "trie"

class Boggle
  attr_accessor :letters, :grid, :sqrt, :found_words

  def self.solve(letters)
    bg = new letters, load: true
    bg.solve_grid
    bg.found_words
  end

  # Pass load: true to load trie from dictionary upon instantiation
  def initialize(letters, load:false)
    validate(letters)

        @letters = letters.downcase
           @sqrt = Math.sqrt(@letters.length).to_i
           @grid = letters_to_grid
    @found_words = WordStore.new

       load_trie if load
  end

  def solve_grid
    for_each_letter {|letter, i, j| solve "", i, j }
  end

  def solve(word, row_index, letter_index, indices=[])
    letter      = grid[row_index][letter_index]

    new_word    = word + letter
    new_indices = indices + [[row_index, letter_index]]

    if is_word?(new_word)
      print "\n#{new_word}\n"
      found_words.add new_word, new_indices
    end

    # check if current word is a valid word root
    # if words_containing(new_word).any?
    if is_prefix?(new_word)
      each_adjacent_letter(row_index, letter_index) do |letter, i, j|
        if new_indices.include? [i, j]
          print "."
        else
          solve new_word, i, j, new_indices
        end
      end
    end
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

  def for_each_letter(&block)
    grid.each_with_index do |row, i|
      row.each_with_index do |letter, j|
        yield letter, i, j
      end
    end
  end

  private

  def load_trie
    @trie = Trie.new

    puts "Loading trie from dictionary..."
    WORDS.each {|word| @trie.add word }
    print "Done!\n"

    @trie
  end

  def validate(lttrs)
    # Invalid unless square number of letters.
    unless Math.sqrt(lttrs.length).to_i == Math.sqrt(lttrs.length)
      raise ArgumentError, "The letters passed do not represent a square grid (#{lttrs})"
    end
  end

  def letters_to_grid
    letters.scan(/.{#{sqrt}}/).map {|str| str.split("") }
  end

  def is_word?(word)
    if @trie
      @trie.is_word? word
    else
      WORDS.include? word
    end
  end

  def is_prefix?(word)
    if @trie
      @trie.is_prefix? word
    else
      WORDS.select {|w| w.match(/^#{word}/) }.any?
    end
  end
end
