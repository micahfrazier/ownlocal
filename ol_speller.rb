require_relative 'Tree'


begin

if (@tree = Tree.new)
    puts "tree created successfully"
end

#forced to move call to plant Tree structure after initializing to fix multiple open file error
@tree.plant_the_tree

user_input = $stdin.gets

print ">"
@tree.check_word(user_input)

puts "Tree planted"

rescue Interrupt
  info "You are exiting the spell checker"
  exit!
end