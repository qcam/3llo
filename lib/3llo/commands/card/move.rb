module Tr3llo
  module Command
    module Card
      module MoveCommand
        extend self

        def execute(key, board_id)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          interface.print_frame do
            list_id = prompt_for_list_id!(board_id)

            move_card!(card_id, list_id)
            interface.puts("Card has been moved.")
          end
        end

        private

        def prompt_for_list_id!(board_id)
          lists = Tr3llo::API::List.find_all_by_board(board_id)

          Tr3llo::Presenter::Card::MovePresenter
            .new(interface)
            .prompt_for_list_id(lists)
        end

        def move_card!(card_id, list_id)
          API::Card.move_to_list(card_id, list_id)
        end

        def interface
          Application.fetch_interface!()
        end

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid list key") unless card_id
        end
      end
    end
  end
end
