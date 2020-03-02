module Tr3llo
  module Command
    module Label
      module List
        extend self

        def execute(board_id)
          interface = Application.fetch_interface!()
          labels = API::Label.find_all_by_board(board_id)

          interface.print_frame do
            interface.puts(View::Label::List.render(labels))
          end
        end
      end
    end
  end
end
