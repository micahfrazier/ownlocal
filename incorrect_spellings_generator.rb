#require_relative 'Tree'
require_relative "Tree"
require_relative "tree_node"





#def flip_vowel(word)
#  s = word
#  c = s.rindex(/aeiouy/)
#  unless c.nil? || c == 0
#    s[c-1] = "e"
#  end
#  s
#end
#
#def mess_with(word)
#  case rand(2)
#  when 0
#    capitalize_repeat(word)
#  when 1
#    flip_vowel(word)
#  else
#    puts "n error has occurred"
#  end
#end

begin
  dictionary = Tree.new
  dictionary.build_the_tree
  incorrect_words = []

  IO.foreach(DICTIONARY) do |w|
    f = w.chomp.strip.downcase
    incorrect_words << f
    #last = incorrect_words.size - 1
    #puts incorrect_words[last]
  end

  errors = {}
  20.times do
    word = incorrect_words.sample.scan(/./)
    mistake = []
    word.each do |char|
      len = mistake.count
      if VOWELS.include?(char) && rand(10) < 3
        mistake << (VOWELS - [char]).sample
        next
      end

      case rand(100)
        when 0..10
          (rand(10) + 1).times { mistake << char }
        when 11..43
          mistake << char.upcase
        else
          mistake << char
      end
    end

    mistake = mistake.join('')

    corrected_word = dictionary.correct_word(mistake)
    errors[word.join('')] = mistake if corrected_word == "NO SUGGESTION"
    puts corrected_word

  end

  puts "Finished successfully with incorrect words generator"
end