require_relative 'Tree'
require_relative 'tree_node'

begin
  puts "Building the dictionary."
  dictionary = Tree.new

  if dictionary.build_the_tree
    puts "Dictionary hashed and loaded successfully"
  else
    puts "Error: dictionary not hashed successfully"
  end

  loop do
    $stdout.write "> "
    user_input = $stdin.gets.strip.downcase
    puts dictionary.correct_word(user_input)
  end

rescue Interrupt
  puts "You are exiting the spell checker"
  exit!
end