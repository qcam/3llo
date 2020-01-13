module Tr3llo
  module Command
    module Board
      module SelectCommand
        extend self

        def execute(key)
          board_id = Entities.parse_id(:board, key)
          assert_board_id!(board_id, key)

          board = API::Board.find(board_id)
          Application.register_board!(board)

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts("Board #{Utils.format_highlight(board.name)} selected")
          end
        end

        private

        def assert_board_id!(board_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid board key") unless board_id
        end
      end
    end
  end
end
