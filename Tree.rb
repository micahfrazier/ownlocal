require_relative 'current_place'

DICTIONARY = "/usr/share/dict/words"   #can

class Tree
  attr_accessor :word, :branch

  #initializing the Tree with a Hash and empty branch then reading in the word list from expected file
  def initialize
    @branch = {}
    @word = nil
  end

  def plant_the_tree
    IO.foreach(DICTIONARY) do |w|
      w = w.strip.downcase
      self.push_onto_tree(w) #inserting the word into the tree
    end
    true
  end


  def push_onto_tree(word_from_file)
    #need to implement recursive call to self (Tree class)
    n = self #set node n equal to Tree
    word_from_file.each_char do |character|
      # check if each "branch element" has other branches
      # if it does not then set n to become a new Tree branch
      # should be able to make a call to self recursively
      unless n.branch.has_key?(character)
        n.branch[character] = Tree.new
      end
      #
      n = n.branch[character]
      #Hooray figured out how to set the branch
    end
    n.word = word_from_file
  end
  
  def traverse(word, d_l_max, place)

    word = ( word.downcase.gsub(/([aeiou])\1{1,}([^aeiou])\2{1,}/i,'\1\1\2').gsub(/(?!^).([^aeiou])\1{1,}/i,'\1').gsub(/([aeiou])\1{2,}/i,'\1\1') )
    results = []
    (0..d_l_max).each do |i|
      # search through the word and push onto the results array
      results << search(word, i, place)
      if (results[0]) then
        (place.reset; return results)
      else
        results.shift
      end
    end
    # If nothing found, reset current place in the word and return nil
    place.reset
    nil
  end

  def search(word, d_l_max, place)
    #damerau-levenshtein row
    currentRow = (0..word.size).to_a

    results = {}
    self.branch.each_key do |key|
      search_rows(self.branch[key], key, word, currentRow, results, d_l_max, place)
    end
    if (!results.empty?)
      matching_start = false
      results.each_key do |result|
        # screwing around with scoring the words to give a better indication of the matches
        # basically guess and check to try and get the CUNsperrICY input to work as it keeps coming up as unspicy
        if (result[0] == word[0])
          results[result] -= 0.4
          matching_start = true
          if (result.length == word.length)
            results[result] -= 0.2
          end
        end
      end
      if (matching_start) then
        results.sort_by { |k, v| v }[0][0]
      else
        false
      end
    else
      false
    end
  end

  def search_rows(tnode, character, word, previousRow, results, d_l_max, place)
    if place.state[d_l_max-1][tnode.object_id]
      currentRow = place.state[d_l_max-1][tnode.object_id]
    else
      currentRow = [previousRow[0] + 1]
      # Norvigish/Damerau-Levenshtein cost calculation where the minimum is sent to the current row
      (1..word.size).each do |column|
        insertion = currentRow[column - 1] + 1
        deletion = previousRow[column] + 1
        transpose = previousRow[column - 1]
        if word[column - 1] != character
          transpose += 1

          if character =~ /[^aeiou]/          # vowels are less expensive
            transpose += 1
          end

        end
        currentRow << [insertion, deletion, transpose].sort.first  #pushes the smallest value from insertion, deletion and replacement to currentRow
      end
      # Set the place for this traversal on this tree
      place.state[d_l_max][tnode.object_id] = currentRow
    end
    if currentRow.last <= d_l_max and tnode.word != nil
      results[tnode.word] = currentRow.last
    end
    # If any enTrees in the row are less than the max distance, then recursively search each branch of the Tree.
    if currentRow.min <= d_l_max
      tnode.branch.each_key do |character|
        search_rows(tnode.branch[character], character, word, currentRow, results, d_l_max, place)
      end
    end
  end



end