module Tr3llo
  module Command
    module Board
      module List
        extend self

        def execute(user_id)
          interface = Application.fetch_interface!()
          boards = API::Board.find_all_by_user(user_id)

          interface.print_frame do
            interface.puts(View::Board::List.render(boards))
          end
        end
      end
    end
  end
end
