require './lib/chess.rb'

chess = Chess.new

loop do
  chess.display
  
  if chess.check?
    if chess.checkmate?
      puts "Checkmate!"
      break
    else
      puts "Check!"
    end
  end

  piece = nil
  loop do
    piece = chess.ask_piece
    break if chess.valid_piece?(piece)
    puts 'Invalid choice! Please try again.'
  end

  move = nil
  loop do
    move = chess.ask_move
    break if chess.valid_move?(piece, move)
    puts 'Invalid move! Please try again.'
  end
  chess.move(piece, move)
  
  chess.switch
end

chess.gameover