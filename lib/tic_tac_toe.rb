class TicTacToe
  def initialize (board = nil)
    @board = board || Array.new(9, " ")
  end
  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  def input_to_index(input)
    input.to_i - 1
  end

  def move (index, current_player)
    @board[index] = current_player
  end
  
  def position_taken?(index)
    @board[index] != " " && @board[index] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn_count
    counter = 0
    @board.each do |location|
      if location != " " && location != ""
        counter += 1
      end
    end
    counter
  end
  
  def current_player 
    count = turn_count
    if count % 2 == 0
      player = "X"
    else
      player = "O"
    end
    player
  end
  
  def turn
    puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      player = current_player
    if valid_move?(index)
      move(index, player)
      display_board
    else
      turn
    end
  end
  
  def won? 
    WIN_COMBINATIONS.each do |combo|
      #creates an array to test with #all?
      posit = [" ", " ", " "]
      counter = 0
      #starts loop to test posit
      combo.each do |windex|
      posit[counter] = @board [windex]
      counter +=1
      #tests for full array
      if posit.all? {|var| var == "X"}
        return combo
      elsif posit.all? {|var| var == "O"}
        return combo
      end
    end
  end
  return false
end

#test if the board is full
  def full?
    #if there is a blank space, returns false, otherwise true
    !(@board.detect {|posit| posit == " "})
  end
  
#test if there is a draw
  def draw? 
    if full? == true
      !won?
    end
  end

#test if game is over
  def over? 
    if draw?
      return true
    elsif won?
      return true
    end
  end

#returns the winner
  def winner 
    if won?
      winrow = won?
      posit = [" ", " ", " "]
      counter = 0
      winrow.each do |windex|
        posit[counter] = @board[windex]
        counter += 1
      end
      if posit.all? {|var| var == "X"}
        return "X"
      elsif posit.all? {|var| var == "O"}
        return "O"
      end
    end
  end

  def play
    until over? == true
      turn 
    end
    if won?
      win_player = winner
      puts "Congratulations #{win_player}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end