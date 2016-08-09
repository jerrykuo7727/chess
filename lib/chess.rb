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
      return true if '♖♘♗♕♔♙'.include?(piece) && can_move?(pos)
      puts "Invalid choice! Please try again."
      false
    else
      return true if '♜♞♝♛♚♟'.include?(piece) && can_move?(pos)
      puts "Invalid choice! Please try again."
      false
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
      unless valid_move_for_king?(pos, move)
        puts "Invalid move! Please try again."
        return false
      end
      true
    when '♕', '♛'
      unless valid_move_for_queen?(pos, move)
        puts "Invalid move! Please try again."
        return false
      end
      true
    when '♖', '♜'
      unless valid_move_for_rook?(pos, move)
        puts "Invalid move! Please try again."
        return false
      end
      true
    when '♗', '♝'
      unless valid_move_for_bishop?(pos, move)
        puts "Invalid move! Please try again."
        return false
      end
      true
    when '♘', '♞'
      unless valid_move_for_knight?(pos, move)
        puts "Invalid move! Please try again."
        return false
      end
      true
    when '♙', '♟'
      unless valid_move_for_pawn?(pos, move)
        puts "Invalid move! Please try again."
        return false
      end
      true
    end
  end

  def move(curr, goal)
    piece = @board[curr[0]][curr[1]]
    @board[curr[0]][curr[1]] = '.'
    @board[goal[0]][goal[1]] = piece
  end

  private

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
    # To-do: cant move to a checked position
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