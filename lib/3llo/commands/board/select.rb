module Tr3llo
  module Command
    module Board
      class SelectCommand
        def execute
          board = load_board(select_board)

          $container.register(:board, board)
          interface.print_frame do
            interface.puts("Board #{board[:name].labelize} selected")
          end
        end

        private

        def select_board
          interface.input.select("Board to select: ", board_choices)
        end

        def board_choices
          user_id = $container.resolve(:user)[:id]
          API::Board
            .find_all_by_user(user_id)
            .map { |board| [board[:name], board[:id]] }
            .to_h
        end

        def load_board(board_id)
          API::Board.find(board_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
