class TicTacToe
Infinity = +1.0/0.0

puts "X or O?"
userSymbol = gets.chomp.to_s.upcase
userSymbol = userSymbol.upcase
if userSymbol != 'X' && userSymbol != 'O' && userSymbol != 'Q'
    abort ("Invalid input.")
elsif userSymbol == 'X'
    aiSymbol = 'O'
    falseSymbol = true
elsif userSymbol == 'O'
    aiSymbol = 'O'
    falseSymbol = true
elsif userSymbol == 'Q'
    abort("You have quit. Thank you.")
end


PLAYER_MARKER = userSymbol.freeze
AI_MARKER = aiSymbol.freeze

def initialize
 @WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]
@board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

end

def winner_search
    [[@board[0],@board[1],@board[2]],[@board[3],@board[4],@board[5]],
     [@board[6],@board[7],@board[8]],[@board[0],@board[3],@board[6]],
     [@board[1],@board[4],@board[7]],[@board[2],@board[5],@board[8]],
     [@board[0],@board[4],@board[8]],[@board[2],@board[4],@board[6]]]
end

def winner_search_algo(board)
    [[board[0],board[1],board[2]],[board[3],board[4],board[5]],
     [board[6],board[7],board[8]],[board[0],board[3],board[6]],
     [board[1],board[4],board[7]],[board[2],board[5],board[8]],
     [board[0],board[4],board[8]],[board[2],board[4],board[6]]]
end

def win_checker(player)

end

def winner_marker_player?
    if winner_search.include? ["#{PLAYER_MARKER}","#{PLAYER_MARKER}","#{PLAYER_MARKER}"]
        #puts "#{PLAYER_MARKER} is the winner!"
        return true
    end
end

def winner_marker_player_algo(board)
    if winner_search_algo(board).include? ["#{PLAYER_MARKER}","#{PLAYER_MARKER}","#{PLAYER_MARKER}"]
        #puts "#{PLAYER_MARKER} is the winner!"
        return true
    end
end

def ai_marker_player_algo(board)
    if winner_search_algo(board).include? ["#{AI_MARKER}","#{AI_MARKER}","#{AI_MARKER}"]
        #puts "#{AI_MARKER} is the winner!"
        return true
    end
end

def ai_marker_player?
    if winner_search.include? ["#{AI_MARKER}","#{AI_MARKER}","#{AI_MARKER}"]
        #puts "#{AI_MARKER} is the winner!"
        return true
    end
end


def tie_game?
     @board.each do |marker|
         if marker == " "
             return false
         end
     end
     return true
end

def tie_game_algo(board)
     board.each do |marker|
         if marker == " "
             return false
         end
     end
     return true
end


def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
end


def position_taken?(userPosition)
    if @board[userPosition.to_i - 1] == " "
        return  true
    else
        return false
    end
end

def ai_move
    aiBestMove(@board, AI_MARKER)
end




def aiBestMove(board, player)
    scores = []
    moves = []
    if winner_marker_player_algo(board)
        return -1
    end

    if ai_marker_player_algo(board)
        return 1
    end

    if tie_game_algo(board)
        return 0
    end


    player == AI_MARKER ? AI_MARKER : PLAYER_MARKER

    for x in 0..8
        if (board[x] == " ")
            new_board_state = board.dup
            new_board_state[x] = "#{player}"
            if player == AI_MARKER
                player = PLAYER_MARKER
            else
                player = AI_MARKER
            end

            move_val = aiBestMove(new_board_state, player)
            scores.push(move_val)
            moves.push(x)
            print(moves[0])
        end
    end
end

def player_move
    isValid = true
    while isValid == true
      puts "Player #{PLAYER_MARKER}'s turn."
      puts "Please enter a position to move"
      display_board
      userPosition = gets.chomp.to_i
      if !valid_entry?(userPosition)
        puts "Invalid entry. Please try again."
        isValid = true
      else
        isValid = false
      end
      if isValid == false
         if !position_taken?(userPosition)
             isValid = true
             puts "Position taken, please try again."
         else

          update_player_board(userPosition)
          display_board
         end
      else

      end
    end
end

def update_player_board(userPosition)
  @board[userPosition-1] = "#{PLAYER_MARKER}"
end

def update_ai_board(aiPosition)
  @board[aiPosition-1] = "#{AI_MARKER}"
end

def valid_entry?(userPosition)
    if userPosition.between?(1,9)
        return true
    else
        return false
    end
end




def play
    puts "Input Y if you want to go first or N if second."
    puts "To quit, enter Q"
    userInput = gets.chomp.to_s.upcase

     if userInput == 'Y'
        9.times do
            player_move
            ai_move
           break if winner_marker_player?
          # break if ai_marker_player?
           break if tie_game?
        end

     elsif userInput == 'N'
      9.times do
            ai_move
            player_move
            break if winner_marker_player?
            #break if ai_marker_player?
            break if tie_game?
        end
     elsif userInput == 'Q'
        abort("You have quit. Thank you.")
     else
        puts "Invalid input."
     end
end
end
newGame = TicTacToe.new
newGame.play
