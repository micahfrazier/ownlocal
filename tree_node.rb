class TreeNode

  attr_accessor :letter, :end_word, :children

  def initialize(letter)
    @letter = letter
    @children = {}
    @end_word = false
  end

  def spellcheck(word)
    return @letter if (word.nil? || word == '') && @end_word

    letters = word.downcase.scan(/./)
    next_letter = letters.shift

    if @children[next_letter]
      result = @children[next_letter].spellcheck(letters.join(''))

      return @letter + result if result.is_a?(String)
    end

    return check_for_repeats(next_letter, letters) if next_letter == self.letter

    return check_for_vowels(next_letter, letters) if VOWELS.include?(next_letter)

    false
  end


  private

  # Checking for vowels and duplicate letters are the only two needs for the project
  # as the 'downcase' method converts all word inputs to lower case

  def check_for_vowels(next_letter, letters)
    vowels_instance = VOWELS - [next_letter]

    vowels_instance.each do |v|
      next unless @children[v]
      result = @children[v].spellcheck(letters.join(''))
      return @letter + result if result.is_a?(String)
    end

    false
  end

  # Checking for repeat letters by looking at the next letter in the word from the user
  def check_for_repeats(next_letter, letters)
    original = next_letter
    region_length = 1
    begin
      next_letter = letters.shift
      region_length += 1
    end while letters.count > 0 && next_letter == @letter

    # if end of the word and it's a valid word the return
    return @letter if letters.count <= 0 && (next_letter == @letter || next_letter == '' || next_letter.nil?) && @end_word

    # checking for repeated vowel permutations
    if VOWELS.include?(original)
      permutations = vowel_permutations(region_length)
      permutations.each do |permute|

        modified_letters = permute + [next_letter] + letters
        ltr = modified_letters.shift
        next unless @children[ltr]
        result = @children[ltr].spellcheck(modified_letters.join(''))

        return @letter + result if result.is_a?(String)
      end
    end

    if @children[next_letter]
      result = @children[next_letter].spellcheck(letters.join(''))

      return @letter + result if result.is_a?(String)
    end

    # looking to see if the next letter is a vowel
    # and if so, call check_for_vowels
    if VOWELS.include?(next_letter)
      return check_for_vowels(next_letter, letters)
    end

    false
  end

  def vowel_permutations(length)
    length = 2 if length > 2 # catch most common cases
    permutations = []

    (0..length).each do |n|
      vowel_multiples = []
      n.times { vowel_multiples += VOWELS }
      permutations += vowel_multiples.permutation(n).to_a
    end
    permutations
  end



end