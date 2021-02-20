WIN_COMBINATIONS = [
  #Horizontal
  [0,1,2],
  [3,4,5],
  [6,7,8],
  #Vertical
  [0,3,6],
  [1,4,7],
  [2,5,8],
  #Diagnal
  [0,4,8],
  [2,4,6],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player = "X")
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end





def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
    # board.count{|token| token == "X" || token == "O"}
  
    turns = 0
    board.each do |token|
      if token == "X" || token == "O"
        turns += 1
      end
    end
    turns
  
  end
  
  def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
  end
  
  def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? {|token| token == "X" || token == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board) && !full?(board)
    return
  else won?(board)
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else false
  end
end  

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end


def play(board)
  until over?(board) do
  turn(board)
end
if won?(board)
  puts "Congratulate #{winner(board)}"
elsif draw?(board)
  puts "Cat's Game"
end