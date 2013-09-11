#require_relative 'Tree'
require_relative "Tree"




def capitalize_repeat(word)
  s = word
  s[0].swapcase!
  s.insert(s.size - 1, "e" * 3)
  s
end

def flip_vowel(word)
  s = word
  c = s.rindex(/aeiouy/)
  unless c.nil? || c == 0
    s[c-1] = "e"
  end
  s
end

def fuck_with(word)
  case rand(2)
    when 0
      capitalize_repeat(word)
    when 1
      flip_vowel(word)
  end

end

begin
  tree = Tree.new
  place = CurrentPlace.new
  tree.plant_the_tree
  incorrect_words = []
  IO.foreach(DICTIONARY) do |w|
    f = w.chomp.strip.downcase
    d = fuck_with(f)
    incorrect_words << d
    #last = incorrect_words.size - 1
    #puts incorrect_words[last]
  end

  20.times do
    puts tree.traverse(incorrect_words[rand(rand(incorrect_words.size - 1))],25, place)
  end


rescue
  warn("an error has occurred")
end