class Chess
  def initialize
    @board = [['♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜'],
              ['♟', '♟', '♟', '♟', '♟', '♟', '♟', '♟'],
              ['.', '.', '.', '.', '.', '.', '.', '.'],
              ['.', '.', '.', '.', '.', '.', '.', '.'],
              ['.', '.', '.', '.', '.', '.', '.', '.'],
              ['.', '.', '.', '.', '.', '.', '.', '.'],
              ['♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙'],
              ['♖', '♘', '♗', '♕', '♔', '♗', '♘', '♖']]
    @turn = 'White'
  end

  def display
    puts '   ａ ｂ ｃ ｄ ｅ ｆ ｇ ｈ'
    @board.each_with_index do |row, i|
      print (8 - i).to_s
      print ' |'
      print row.join('|').gsub('.', '＿')
      print '| '
      puts print (8 - i).to_s
    end
    puts '   ａ ｂ ｃ ｄ ｅ ｆ ｇ ｈ '
  end
  
  def ask_piece
    piece = nil
    until valid_input?(piece)
      print "(#{@turn}) Which piece to move: "
      piece = gets.chomp.downcase
    end
    return [56 - piece[1].ord, piece[0].ord - 97]
  end

  def valid_piece?(pos)
    return false unless pos.class == Array
    piece = @board[pos[0]][pos[1]]
    if @turn == 'White'
      if '♖♘♗♕♔♙'.include?(piece)
        true
      else
        puts "Invalid choice! Please try again."
        false
      end
    else
      if '♜♞♝♛♚♟'.include?(piece)
        true
      else
        puts "Invalid choice! Please try again."
        false
      end
    end
  end

  def ask_move
    piece = nil
    until valid_input?(piece)
      print "(#{@turn}) Move piece to where: "
      piece = gets.chomp.downcase
    end
    return [56 - piece[1].ord, piece[0].ord - 97]
  end

  def valid_move?(pos, move)
    return false unless pos.class == Array && move.class == Array
    piece = @board[pos[0]][pos[1]]
    case piece
    when '♔', '♚'
      valid_move_for_king?(pos, move)
    when '♕', '♛'
      puts 'Queen~~'
    when '♖', '♜'
      puts 'Rook~~'
    when '♗', '♝'
      puts 'Bishop~~'
    when '♘', '♞'
      puts 'Knight~~'
    when '♙', '♟'
      puts 'Pawn~~'
    end
  end

  private

  def valid_input?(input)
    return false unless input.class == String
    return false unless input.length == 2
    return false unless 'ABCDEFGHabcdefgh'.include?(input[0])
    return false unless '12345678'.include?(input[1])
    return true
  end

  def valid_move_for_king?(pos, move)
    #TO-DO: Checkmate judgement
    return false unless [-1, 0, 1].include?(move[0] - pos[0])
    return false unless [-1, 0, 1].include?(move[1] - pos[1])

    goal = @board[move[0]][move[1]]
    return false if @turn == 'White' && '♖♘♗♕♔♙'.include?(goal)
    return false if @turn == 'Black' && '♜♞♝♛♚♟'.include?(goal)
    return true
  end

  def valid_move_for_queen?(pos, move)
    path = [move[0] - pos[0], move[1] - pos[1]]
    return false unless path[1] == 0 || [-1, 0, 1].include?(1.0 * path[0] / path[1])

    unit = [0, 0]
    unit[0] = -1 if path[0] < -1
    unit[0] = 1 if path[0] > 1
    unit[1] = -1 if path[1] < -1
    unit[1] = 1 if path[1] > 1

    curr = [pos[0] + unit[0], pos[1] + unit[1]]
    until curr == move do
      piece = @board[curr[0]][curr[1]]
      return false unless piece == '.' 
      curr[0] += unit[0]
      curr[1] += unit[1]
    end

    goal = @board[move[0]][move[1]]
    return false if @turn == 'White' && '♖♘♗♕♔♙'.include?(goal)
    return false if @turn == 'Black' && '♜♞♝♛♚♟'.include?(goal)
    return true
  end
end

chess = Chess.new