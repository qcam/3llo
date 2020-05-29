module Tr3llo
  module Command
    module Card
      module Move
        extend self

        def execute(key, board_id)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          interface = Application.fetch_interface!()

          interface.print_frame do
            selected_list_id = select_list(interface, board_id)

            API::Card.move_to_list(card_id, selected_list_id)
            interface.puts("Card has been moved.")
          end
        end

        private

        def select_list(interface, board_id)
          list_options =
            API::List
              .find_all_by_board(board_id)
              .map { |list| [list.name, list.id] }
              .to_h()

          interface.input.select(
            "Choose the list to be moved to",
            list_options
          )
        end

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid card key") unless card_id
        end
      end
    end
  end
end
