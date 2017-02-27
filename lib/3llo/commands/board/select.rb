module Tr3llo
  module Command
    module Board
      class SelectCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          board = load_board
          $container.register(:board, board)
          interface.print_frame do
            interface.puts("Board #{board[:name].labelize} selected")
          end
        end

        private

        attr_reader :board_id

        def load_board
          API::Board.find(board_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
