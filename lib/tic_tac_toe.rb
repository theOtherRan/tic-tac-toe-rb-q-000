WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # left diagonal
  [6,4,2] # right diagonal
  ]

def display_board(board)
  puts " #{board[0]} " + "| #{board[1]} |" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "| #{board[4]} |" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "| #{board[7]} |" + " #{board[8]} "
end

board = [" "," "," "," "," "," "," "," "," "]

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win = win_combination.all? do |location|
      board[location] == "X"
    end
    if win
      return win_combination
    end
    win = win_combination.all? do |location|
      board[location] == "O"
    end
    if win
      return win_combination
    end
  end
  return false
end


def full?(board)
  full_board = board.all? do |index|
    index == "X" || index == "O"
  end
  if full_board
      return true
  else
    return false
  end
end

def draw?(board)
  if !(won?(board)) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  return nil if !(won?(board))
  return "X" if board[won?(board)[0]] == "X"
  return "O" if board[won?(board)[0]] == "O"
end

def play(board)
  until over?(board)
    turn(board)
    break if won?(board) || draw?(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end





