module Tr3llo
  module Command
    module Board
      module Select
        extend self

        def execute(board_key)
          board_id = Entities.parse_id(:board, board_key)
          assert_board_id!(board_id, board_key)

          board = API::Board.find(board_id)
          Application.register_board!(board)

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts("Board #{Utils.format_highlight(board.name)} selected")
          end
        end

        private

        def assert_board_id!(board_id, board_key)
          raise InvalidArgumentError.new("#{board_key.inspect} is not a valid board key") unless board_id
        end
      end
    end
  end
end
