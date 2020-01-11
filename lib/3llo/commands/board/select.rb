module Tr3llo
  module Command
    module Board
      module SelectCommand
        extend self

        def execute(key)
          board_id = Entities.parse_id(:board, key)
          assert_board_id!(board_id, key)

          board = get_board(board_id)

          $container.register(:board, board)

          interface.print_frame do
            interface.puts("Board #{Utils.format_highlight(board.name)} selected")
          end
        end

        private

        def get_board(board_id)
          API::Board.find(board_id)
        end

        def interface
          Application.fetch_interface!()
        end

        def assert_board_id!(board_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid board key") unless board_id
        end
      end
    end
  end
end
