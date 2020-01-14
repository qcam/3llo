module Tr3llo
  module Command
    module List
      module List
        extend self

        def execute(board_id)
          interface = Application.fetch_interface!()
          lists = API::List.find_all_by_board(board_id)

          interface.print_frame do
            interface.puts(View::List::List.render(lists))
          end
        end
      end
    end
  end
end
