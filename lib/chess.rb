class Chess
  attr_reader :board

  def initialize
    @board = [['♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜'],
              ['♟', '♟', '♟', '♟', '♟', '♟', '♟', '♟'],
              ['.', '.', '.', '.', '.', '.', '.', '.'],
              ['.', '.', '.', '.', '.', '.', '.', '.'],
              ['.', '.', '.', '.', '.', '.', '.', '.'],
              ['.', '.', '.', '.', '.', '.', '.', '.'],
              ['♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙'],
              ['♖', '♘', '♗', '♕', '♔', '♗', '♘', '♖']]
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
      print 'Which piece to move: '
      piece = gets.chomp.downcase
    end
  end

  def valid_input?(input)
    return false unless input.class == String
    return false unless input.length == 2
    return false unless 'ABCDEFGHabcdefgh'.include?(input[0])
    return false unless '12345678'.include?(input[1])
    return true
  end
end

chess = Chess.new
p chess.valid_input?('A0')