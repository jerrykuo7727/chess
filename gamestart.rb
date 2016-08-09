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
    break if piece == 'save' || piece == 'load'
    break if chess.valid_piece?(piece)
    puts 'Invalid choice! Please try again.'
  end

  if piece == 'save'
    savedata = YAML.dump(chess)
    File.open('savedata.yaml', 'w') do |file|
      file.truncate(0)
      file.write(savedata)
    end
    next
  elsif piece == 'load'
    savedata = File.read('savedata.yaml')
    chess = YAML.load(savedata)
    next
  end

  move = nil
  loop do
    move = chess.ask_move
    break if move == 'save' || move == 'load'
    break if chess.valid_move?(piece, move)
    puts 'Invalid move! Please try again.'
  end

  if move == 'save'
    savedata = YAML.dump(chess)
    File.open('savedata.yaml', 'w') do |file|
      file.truncate(0)
      file.write(savedata)
    end
    next
  elsif move == 'load'
    savedata = File.read('savedata.yaml')
    chess = YAML.parse(savedata)
    next
  end

  chess.move(piece, move)
  chess.switch
end

chess.gameover