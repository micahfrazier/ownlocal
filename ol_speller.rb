require_relative 'Tree'
require_relative 'current_place'

LONGEST_WORD = 25 #longest word in the dictionary

begin
place = CurrentPlace.new
tree = Tree.new
#forced to move call to plant Tree structure after initializing to fix multiple open file error
if tree.plant_the_tree
  puts "Dictionary hashed and loaded successfully"
else
  puts "Error: dictionary not hashed successfully"
end


loop do
  print "> "
  user_input = $stdin.gets.strip
  corrected_word = tree.traverse(user_input, LONGEST_WORD, place)
  unless corrected_word.nil?
    puts corrected_word
  else
    puts 'NO SUGGESTION'
  end
end

rescue Interrupt
  puts "You are exiting the spell checker"
  exit!
end