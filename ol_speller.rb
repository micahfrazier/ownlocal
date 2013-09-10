require_relative 'Tree'


begin

  if (@tree = Tree.new)
    puts "tree created successfully"
  end

rescue Interrupt
  info "You are exiting the spell checker"
  exit!
end