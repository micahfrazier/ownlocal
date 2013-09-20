VOWELS = ["a", "e", "i", "o", "u", "y"]
DICTIONARY = "/usr/share/dict/words"   #can

class Tree

  def initialize
    @root = {}
    ('a'..'z').each do |letter|
      @root[letter] = TreeNode.new(letter)
    end
  end

  def build_the_tree
    IO.foreach(DICTIONARY) do |w|
      w = w.strip.downcase
      self.push_onto_tree(w) #inserting the word into the tree
    end

    true
  end


  def push_onto_tree(word_from_file)
    #need to implement recursive call to self (Tree class)
    #set node n equal to Tree
    # check if each "node element" has other nodes
    # if it does not then set n to become a new Tree branch
    # should be able to make a call to self recursively
    return if word_from_file.nil? || word_from_file == ''

    word = word_from_file.gsub(/\s/, '').downcase.scan(/./)
    root_letter = word.shift
    last_node = @root[root_letter]

    word.reduce(last_node) do |node, letter|
      node.children[letter] ||= TreeNode.new(letter)
      node = node.children[letter]
      last_node = node
    end

    last_node.end_word = true  # end of the word has been reached
  end

  def correct_word(word)
    letters = word.downcase.scan(/./)
    root_letter = letters.shift
    result = @root[root_letter].spellcheck(letters.join(''))
    vowels = VOWELS  # set as

    if !result && vowels.include?(root_letter)
      vowels -= [root_letter]

      vowels.each do |v|
        next if result
        result = @root[v].spellcheck(letters.join(''))
      end
    end

    result ? result : "NO SUGGESTION"  # returns No Suggestion if correction not found
  end

end