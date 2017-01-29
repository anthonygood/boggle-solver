module Boggle
  class LetterPicker
    # Influence distribution of letters
    CONSONANTS = "BBCCCCDDDDFFGGGHHHHHJKKLLLLLMMMNNNNNNNNPPQRRRRRRRRRSSSSSSSTTTTTTTTTTVVWWWXYYYZ".split("")
    VOWELS     = "AAAAEEEEEEEIIIOOOUU".split("")

    class << self
      def pick_letters(count)
        vowels_count     = ( count * 0.4 ).floor
        consonants_count = count - vowels_count

        ( vowels(vowels_count) + consonants(consonants_count) ).shuffle.join
      end

      def vowels(count)
        count.times.map { VOWELS.sample }
      end

      def consonants(count)
        count.times.map { CONSONANTS.sample }
      end
    end
  end
end
