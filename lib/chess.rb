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
    @last_move = nil
    @checked = false
    @saving = false
  end

  def display
    puts
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
    return false if @checked && !valid_move?(pos, @last_move)

    piece = @board[pos[0]][pos[1]]
    if @turn == 'White'
      if '♖♘♗♕♔♙'.include?(piece) && can_move?(pos)
        @saving = true if @checked
        return true 
      else
        false
      end
    else
      if '♜♞♝♛♚♟'.include?(piece) && can_move?(pos)
        @saving = true if @checked
        return true
      else
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
    return false if @saving && move != @last_move
    
    piece = @board[pos[0]][pos[1]]
    case piece
    when '♔', '♚'
      unless valid_move_for_king?(pos, move)
        return false
      end
      true
    when '♕', '♛'
      unless valid_move_for_queen?(pos, move)
        return false
      end
      true
    when '♖', '♜'
      unless valid_move_for_rook?(pos, move)
        return false
      end
      true
    when '♗', '♝'
      unless valid_move_for_bishop?(pos, move)
        return false
      end
      true
    when '♘', '♞'
      unless valid_move_for_knight?(pos, move)
        return false
      end
      true
    when '♙', '♟'
      unless valid_move_for_pawn?(pos, move)
        return false
      end
      true
    end
  end

  def move(curr, goal)
<<<<<<< HEAD
    piece = @board[curr[0]][curr[1]]
    @board[curr[0]][curr[1]] = '.'
    @board[goal[0]][goal[1]] = piece
    @last_move = goal
    @checked = false
    @saving = false

    if (piece == '♙' && goal[0] == 0) || (piece == '♟' && goal[0] == 7)
      display
      input = nil
      loop do 
        print "(#{@turn})Turn the pawn into: "
        input = gets.chomp.downcase
        break if ['queen', 'rook', 'bishop', 'knight'].include?(input)
        puts "Invalid piece! Please try again."
      end
      case input
      when 'queen'
        @board[goal[0]][goal[1]] = '♕' if piece == '♙'
        @board[goal[0]][goal[1]] = '♛' if piece == '♟'
      when 'rook'
        @board[goal[0]][goal[1]] = '♖' if piece == '♙'
        @board[goal[0]][goal[1]] = '♜' if piece == '♟'
      when 'bishop'
        @board[goal[0]][goal[1]] = '♗' if piece == '♙'
        @board[goal[0]][goal[1]] = '♝' if piece == '♟'
      when 'knight'
        @board[goal[0]][goal[1]] = '♘' if piece == '♙'
        @board[goal[0]][goal[1]] = '♞' if piece == '♟'
      end
    end
  end

  def check?(pos=nil)
    if pos == nil
      king = find_king
      if valid_move?(@last_move, king)
        @checked = true
        return true
      else
        @checked = false
        return false
      end
    else
      @board.each_with_index do |arr, row|
        arr.each_with_index do |e, col|
          if @turn == 'White'
            if '♜♞♝♛♟'.include?(e) && valid_move?([row, col], pos)
              return true
            end
            moves = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
            path = [pos[0] - row, pos[1] - col]
            if e == '♚' && moves.include?(path)
              return true
            end
          else
            if '♖♘♗♕♙'.include?(e) && valid_move?([row, col], pos)
              return true
            end
            moves = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
            path = [pos[0] - row, pos[1] - col]
            if e == '♔' && moves.include?(path)
              return true 
            end
          end
        end
      end
      false
    end
  end

  def checkmate?
    king = find_king
    king_can_move = false
    paths = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
    until paths.empty?
      path = paths.pop
      pos = [king[0] + path[0], king[1] + path[1]]
      next if out_of_board?(pos)
      king_can_move = true if valid_move_for_king?(king, pos)
    end
    return false if king_can_move

    only_king = true
    @board.each_with_index do |arr, row|
      found = false
      arr.each_with_index do |e, col|
        if '♖♘♗♕♙'.include?(e) && @turn == 'White'
          only_king = false
          found = true
          break
        elsif '♜♞♝♛♟'.include?(e) && @turn == 'Black'
          only_king = false
          found = true
          break
        end
      end
      break if found
    end
    return true if only_king

    if @checked
      @board.each_with_index do |arr, row|
        arr.each_with_index do |e, col|
          if @turn == 'White'
            return false if '♖♘♗♕♙'.include?(e) && valid_move?([row, col], @last_move)
          else
            return false if '♜♞♝♛♟'.include?(e) && valid_move?([row, col], @last_move)
          end
        end
      end
      return true
    end
    false
  end

  def switch
    if @turn == 'White'
      @turn = 'Black'
    else
      @turn = 'White'
    end
  end

  def gameover
    puts 'Black wins the game!' if @turn == 'White'
    puts 'White wins the game!' if @turn == 'Black'
=======
    piece = @board[pos[0]][pos[1]]
    @board[curr[0]][curr[1]] = '.'
    @board[goal[0]][goal[1]] = piece
>>>>>>> dadf2c8138adbb633c0b0c5fcbfa202b738b6b62
  end

  private

  def find_king
    king = nil
    @board.each_with_index do |arr, row|
      arr.each_with_index do |e, col|
        king = [row, col] if e == '♔' && @turn == 'White'
        king = [row, col] if e == '♚' && @turn == 'Black'
      end
    end
    king
  end

  def valid_input?(input)
    return false unless input.class == String
    if input.length != 2
      puts "Invalid input! Please try again."
      return false
    else
      valid = true
      valid = false unless 'ABCDEFGHabcdefgh'.include?(input[0])
      valid = false unless '12345678'.include?(input[1])
      unless valid
        puts "Invalid input! Please try again."
        return false
      end
    true
    end
  end

  def can_move?(pos)
    piece = @board[pos[0]][pos[1]]
    case piece
    when '♘', '♞'
      paths = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
      until paths.empty?
        path = paths.pop
        move = [pos[0] + path[0], pos[1] + path[1]]
        next if out_of_board?(move)
        return true if valid_move_for_knight?(pos, move)
      end
      false
    when '♙'
      paths = [[-1,0],[-2,0],[-1,1],[-1,-1]]
      until paths.empty?
        path = paths.pop
        move = [pos[0] + path[0], pos[1] + path[1]]
        next if out_of_board?(move)
        return true if valid_move_for_pawn?(pos, move)
      end
      false
    when '♟'
      paths = [[1,0],[2,0],[1,1],[1,-1]]
      until paths.empty?
        path = paths.pop
        move = [pos[0] + path[0], pos[1] + path[1]]
        next if out_of_board?(move)
        return true if valid_move_for_pawn?(pos, move)
      end
      false
    when '♔', '♚'
      paths = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
      until paths.empty?
        path = paths.pop
        move = [pos[0] + path[0], pos[1] + path[1]]
        next if out_of_board?(move)
        return true if valid_move_for_king?(pos, move)
      end
      false
    when '♕', '♛'
      paths = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
      until paths.empty?
        path = paths.pop
        move = [pos[0] + path[0], pos[1] + path[1]]
        next if out_of_board?(move)
        return true if valid_move_for_queen?(pos, move)
      end
      false
    when '♖', '♜'
      paths = [[0,1],[1,0],[0,-1],[-1,0]]
      until paths.empty?
        path = paths.pop
        move = [pos[0] + path[0], pos[1] + path[1]]
        next if out_of_board?(move)
        return true if valid_move_for_rook?(pos, move)
      end
      false
    when '♗', '♝'
      paths = [[1,1],[1,-1],[-1,-1],[-1,1]]
      until paths.empty?
        path = paths.pop
        move = [pos[0] + path[0], pos[1] + path[1]]
        next if out_of_board?(move)
        return true if valid_move_for_bishop?(pos, move)
      end
      false
    end
  end

  def valid_move_for_king?(pos, move)
    return false if check?(move)
    return false unless [-1, 0, 1].include?(move[0] - pos[0])
    return false unless [-1, 0, 1].include?(move[1] - pos[1])

    return false unless valid_goal?(pos, move)
    true
  end

  def valid_move_for_queen?(pos, move)
    path = [move[0] - pos[0], move[1] - pos[1]]
    return false unless path[1] == 0 || [-1, 0, 1].include?(1.0 * path[0] / path[1])

    unit = get_unit_path(path)
    return false if path_blocked?(pos, unit, move)

    return false unless valid_goal?(pos, move)
    true
  end

  def valid_move_for_bishop?(pos, move)
    path = [move[0] - pos[0], move[1] - pos[1]]
    return false unless path[1] != 0 && [-1, 1].include?(1.0 * path[0] / path[1])

    unit = get_unit_path(path)
    return false if path_blocked?(pos, unit, move)

    return false unless valid_goal?(pos, move)
    true
  end

  def valid_move_for_rook?(pos, move)
    path = [move[0] - pos[0], move[1] - pos[1]]
    return false unless path[0] == 0 || path[1] == 0

    unit = get_unit_path(path)
    return false if path_blocked?(pos, unit, move)

    return false unless valid_goal?(pos, move)
    true
  end

  def valid_move_for_knight?(pos, move)
    path = [move[0] - pos[0], move[1] - pos[1]]
    return false unless [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]].include?(path)

    return false unless valid_goal?(pos, move)
    true
  end

  def valid_move_for_pawn?(pos, move)
    path = [move[0] - pos[0], move[1] - pos[1]]
    curr_piece = @board[pos[0]][pos[1]]
    goal_piece = @board[move[0]][move[1]]
    if curr_piece == '♙'
      case path
      when [-1,0]
        return false unless goal_piece == '.'
        true
      when [-2,0]
        return false unless pos[0] == 6 
        return false if path_blocked?(pos, [-1,0], move)
        return false unless goal_piece == '.'
        true
      when [-1,1], [-1,-1]
        return false unless '♜♞♝♛♚♟'.include?(goal_piece)
        true
      else
        false
      end
    else
      case path
      when [1,0]
        return false unless goal_piece == '.'
        true
      when [2,0]
        return false unless pos[0] == 1
        return false if path_blocked?(pos, [1,0], move)
        return false unless goal_piece == '.'
        true
      when [1,1], [1,-1]
        return false unless '♖♘♗♕♔♙'.include?(goal_piece)
        true
      else
        false
      end
    end
  end

  def get_unit_path(path)
    unit = [0, 0]
    unit[0] = -1 if path[0] <= -1
    unit[0] = 1 if path[0] >= 1
    unit[1] = -1 if path[1] <= -1
    unit[1] = 1 if path[1] >= 1
    unit
  end

  def path_blocked?(pos, unit, move)
    curr = [pos[0] + unit[0], pos[1] + unit[1]]
    until curr == move do
      piece = @board[curr[0]][curr[1]]
      return true unless piece == '.' 
      curr[0] += unit[0]
      curr[1] += unit[1]
    end
    false
  end

  def valid_goal?(curr, goal)
    curr_piece = @board[curr[0]][curr[1]]
    goal_piece = @board[goal[0]][goal[1]]
    return false if '♖♘♗♕♔♙'.include?(curr_piece) && '♖♘♗♕♔♙'.include?(goal_piece)
    return false if '♜♞♝♛♚♟'.include?(curr_piece) && '♜♞♝♛♚♟'.include?(goal_piece)
    true
  end

  def out_of_board?(pos)
    return false if (0..7).include?(pos[0]) && (0..7).include?(pos[1])
    true
  end
end