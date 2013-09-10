require 'Tree'


begin
  if File.exists?('/usr/share/dict/words')
    planted_tree = Tree.new

    while input != "quit" || input.empty?
      puts ">"
      input = $stdin.gets
    end

  end
rescue Interrupt
  info "You are exiting the spell checker"
  exit!
end