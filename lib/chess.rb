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
end

chess = Chess.new
chess.display