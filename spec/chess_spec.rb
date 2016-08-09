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
              [['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '♘', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '♔', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '.', '.', '.'],
               ['.', '.', '♘', '.', '.', '♘', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.'],
               ['.', '.', '.', '.', '.', '.', '.', '.']])
      expect(chess.send(:valid_move_for_king?, [3,3], [2,4])).to eql(true)
      expect(chess.send(:valid_move_for_king?, [3,3], [2,5])).to eql(false)
      expect(chess.send(:valid_move_for_king?, [3,3], [4,2])).to eql(false)
    end 
  end
end