require 'chess'

describe Chess do
  let(:chess) { Chess.new }

  describe '#valid_move_for_king?' do
    it 'returns true when clear to move' do
      chess.instance_variable_set(:@board,
              [['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '♞', '.', '.', '.', '.'],
               ['.', '.', '.', '♔', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
      expect(chess.send(:valid_move_for_king?, [3,3], [2,4])).to eql(true)
      expect(chess.send(:valid_move_for_king?, [3,3], [2,3])).to eql(true)
      expect(chess.send(:valid_move_for_king?, [3,3], [2,5])).to eql(false)
      expect(chess.send(:valid_move_for_king?, [3,3], [4,2])).to eql(false)
    end 
  end

  describe '#valid_move_for_queen?' do
    it 'returns true when clear to move' do
      chess.instance_variable_set(:@board,
              [['.', '.', '.', '.', '.', '.', '♘', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '♕', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '♞', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
      expect(chess.send(:valid_move_for_queen?, [3,3], [7,3])).to eql(true)
      expect(chess.send(:valid_move_for_queen?, [3,3], [3,7])).to eql(true)
      expect(chess.send(:valid_move_for_queen?, [3,3], [5,5])).to eql(true)
      expect(chess.send(:valid_move_for_queen?, [3,3], [6,0])).to eql(false)
      expect(chess.send(:valid_move_for_queen?, [3,3], [1,2])).to eql(false)
      expect(chess.send(:valid_move_for_queen?, [3,3], [0,6])).to eql(false)
    end
  end

  describe '#valid_move_for_bishop?' do
    it 'returns true when clear to move' do
      chess.instance_variable_set(:@board,
              [['.', '.', '.', '.', '.', '.', '♘', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '♗', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '♞', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
      expect(chess.send(:valid_move_for_bishop?, [3,3], [0,0])).to eql(true)
      expect(chess.send(:valid_move_for_bishop?, [3,3], [5,5])).to eql(true)
      expect(chess.send(:valid_move_for_bishop?, [3,3], [6,0])).to eql(false)
      expect(chess.send(:valid_move_for_bishop?, [3,3], [0,6])).to eql(false)
    end
  end

  describe '#valid_move_for_rook?' do
    it 'returns true when clear to move' do
      chess.instance_variable_set(:@board,
              [['.', '.', '.', '♘', '.', '.', '♘', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '♖', '.', '♘', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '♞', '.', '.'],
               ['♘', '.', '.', '♞', '.', '.', '.', '.'],
               ['♖', '.', '.', '.', '.', '.', '.', '.']])
      expect(chess.send(:valid_move_for_rook?, [3,3], [3,1])).to eql(true)
      expect(chess.send(:valid_move_for_rook?, [3,3], [6,3])).to eql(true)
      expect(chess.send(:valid_move_for_rook?, [3,3], [0,3])).to eql(false)
      expect(chess.send(:valid_move_for_rook?, [3,3], [3,7])).to eql(false)
      expect(chess.send(:valid_move_for_rook?, [3,3], [0,0])).to eql(false)
      expect(chess.send(:valid_move_for_rook?, [7,0], [5,0])).to eql(false)
    end
  end

  describe '#valid_move_for_knight?' do
    it 'returns true when clear to move' do
      chess.instance_variable_set(:@board,
              [['.', '.', '.', '♘', '.', '.', '♘', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '.', '.', '♖', '.', '.'],
               ['.', '.', '.', '♘', '.', '♘', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '♞', '.', '.', '.'],
               ['.', '.', '.', '♞', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
      expect(chess.send(:valid_move_for_knight?, [3,3], [1,4])).to eql(true)
      expect(chess.send(:valid_move_for_knight?, [3,3], [5,2])).to eql(true)
      expect(chess.send(:valid_move_for_knight?, [3,3], [5,4])).to eql(true)
      expect(chess.send(:valid_move_for_knight?, [3,3], [2,5])).to eql(false)
    end
  end

  describe '#valid_move_for_pawn?' do
    it 'returns true when white pawn clear to move' do
      chess.instance_variable_set(:@board,
              [['.', '.', '.', '♘', '.', '.', '♘', '.'],
               ['.', '.', '.', '.', '.', '♟', '♟', '.'],
               ['.', '♘', '.', '.', '♟', '♗', '.', '.'],
               ['.', '.', '.', '.', '.', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '♞', '♙', '♞', '.', '.', '.'],
               ['.', '♙', '♙', '♞', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
      expect(chess.send(:valid_move_for_pawn?, [6,1], [5,1])).to eql(true)
      expect(chess.send(:valid_move_for_pawn?, [6,1], [4,1])).to eql(true)
      expect(chess.send(:valid_move_for_pawn?, [6,1], [5,2])).to eql(true)
      expect(chess.send(:valid_move_for_pawn?, [6,1], [6,0])).to eql(false)
      expect(chess.send(:valid_move_for_pawn?, [6,2], [5,2])).to eql(false)
      expect(chess.send(:valid_move_for_pawn?, [5,3], [4,3])).to eql(true)
      expect(chess.send(:valid_move_for_pawn?, [5,3], [3,3])).to eql(false)
    end

    it 'returns true when black pawn clear to move' do
      chess.instance_variable_set(:@board,
              [['.', '.', '.', '♘', '.', '.', '♘', '.'],
               ['.', '.', '.', '.', '.', '♟', '♟', '.'],
               ['.', '♘', '.', '.', '♟', '♗', '.', '.'],
               ['.', '.', '.', '.', '.', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '♞', '♙', '♞', '.', '.', '.'],
               ['.', '♙', '♙', '♞', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
      expect(chess.send(:valid_move_for_pawn?, [1,6], [2,6])).to eql(true)
      expect(chess.send(:valid_move_for_pawn?, [1,6], [3,6])).to eql(true)
      expect(chess.send(:valid_move_for_pawn?, [1,6], [2,5])).to eql(true)
      expect(chess.send(:valid_move_for_pawn?, [1,6], [1,7])).to eql(false)
      expect(chess.send(:valid_move_for_pawn?, [1,5], [2,5])).to eql(false)
      expect(chess.send(:valid_move_for_pawn?, [2,4], [3,4])).to eql(true)
      expect(chess.send(:valid_move_for_pawn?, [2,4], [4,4])).to eql(false)
    end
  end

  describe '#can_move?' do
    it 'returns true when the piece can possibly move' do
      chess.instance_variable_set(:@board,
              [['♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜'],
               ['♟', '♟', '♟', '♟', '♟', '♟', '♟', '♟'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙'],
               ['♖', '♘', '♗', '♕', '♔', '♗', '♘', '♖']])
      expect(chess.send(:can_move?, [6,0])).to eql(true)
      expect(chess.send(:can_move?, [7,1])).to eql(true)
      expect(chess.send(:can_move?, [7,0])).to eql(false)
      expect(chess.send(:can_move?, [7,2])).to eql(false)
      expect(chess.send(:can_move?, [7,3])).to eql(false)
      expect(chess.send(:can_move?, [7,4])).to eql(false)
    end
  end

  describe '#check?' do
    context 'given no parameters' do
      it 'returns true when the king is checked' do
        chess.instance_variable_set(:@turn, 'Black')
        chess.instance_variable_set(:@last_move, [2,7])
        chess.instance_variable_set(:@board, 
              [['.', '.', '.', '.', '.', '♚', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '♞', '.', '.', '.', '♕'],
               ['.', '.', '.', '♔', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
        expect(chess.check?).to eql(true)

        chess.instance_variable_set(:@last_move, [2,6])
        chess.instance_variable_set(:@board, 
              [['.', '.', '.', '.', '.', '♚', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '♞', '.', '.', '♕', '.'],
               ['.', '.', '.', '♔', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
        expect(chess.check?).to eql(false)

        chess.instance_variable_set(:@turn, 'White')
        chess.instance_variable_set(:@last_move, [5,4])
        chess.instance_variable_set(:@board, 
              [['.', '.', '.', '.', '.', '♚', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '♞', '.', '.', '.', '.'],
               ['.', '.', '.', '♔', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '♞', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])

        expect(chess.check?).to eql(true)
        chess.instance_variable_set(:@last_move, [5,4])
        chess.instance_variable_set(:@board, 
              [['.', '.', '.', '.', '.', '♚', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '♞', '.', '.', '.', '.'],
               ['.', '.', '♔', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '♞', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
        expect(chess.check?).to eql(false)
      end
    end

    context 'given a specific position' do
      it 'returns true if the position is checked' do
        chess.instance_variable_set(:@turn, 'Black')
        chess.instance_variable_set(:@board, 
              [['.', '.', '.', '.', '.', '♚', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '♘', '.', '.', '.', '.'],
               ['.', '.', '.', '♕', '♘', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '♞', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
        expect(chess.check?([0,4])).to eql(true)
        expect(chess.check?([1,4])).to eql(false)
        expect(chess.check?([1,5])).to eql(true)
        expect(chess.check?([1,6])).to eql(false)
        expect(chess.check?([0,6])).to eql(true)
      end
    end
  end
end