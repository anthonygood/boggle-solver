class Word
  attr_accessor :indices

  def initialize
    @word    = ""
    @indices = []
  end

  def val
    @word
  end

  def push(letter, i, j)
    @indices.push [i,j]
    @word += letter
  end

  def already_contains?(i,j)
    @indices.include? [i,j]
  end

  def inspect
    @word
  end

  def to_s
    @word
  end
end
