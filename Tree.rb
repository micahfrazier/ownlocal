class Tree
  attr_accessor :word, :branch

  DICTIONARY = "/usr/share/dict/words"   #can

  #initializing the Tree with a Hash and empty branch then reading in the word list from expected file
  def initialize
    @tree_root = Hash.new
    @branch = {}
    #else
    #  info("File /usr/share/dict/words was not found")
    #  exit!
    #end
  end

  def plant_the_tree
    IO.foreach(DICTIONARY) do |f|
      self.push_onto_tree(f.downcase)
      #puts f
    end
  end


  def push_onto_tree(word_from_file)
    #need to implement recursive call to self (Tree class)
    branch = self
    word_from_file.each_char do |character|
      # check if each "branch element" has other branches
      # if it does not then set self to become a new Tree branch
      # should be able to make a call to self recursively
      if !self.branch.has_key?(character)
        self.branch[character] = Tree.new
        puts "Branching #{character}"
      end
      #
      branch = self.branch[character]  #Hooray figured out how to set the leaf
    end
    branch.word = word_from_file
  end

  def check_word(user_word)
    user_word.downcase!
    puts user_word
  end


  private

  def traverse_tree(word)
    # implement Damerau-Levenshtein algorithm
  end




end