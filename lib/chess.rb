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
    piece = @board[pos[0]][pos[1]]
    if @turn == 'White'
      '♖♘♗♕♔♙'.include?(piece)
    else
      '♜♞♝♛♚♟'.include?(piece)
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
  
  private

  def valid_input?(input)
    return false unless input.class == String
    return false unless input.length == 2
    return false unless 'ABCDEFGHabcdefgh'.include?(input[0])
    return false unless '12345678'.include?(input[1])
    return true
  end
end

chess = Chess.new