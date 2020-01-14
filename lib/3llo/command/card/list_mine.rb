module Tr3llo
  module Command
    module Card
      module ListMine
        extend self

        def execute(board_id, user_id)
          cards = API::Card.find_all_by_user(board_id, user_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts(View::Card::ListMine.render(cards))
          end
        end
      end
    end
  end
end
