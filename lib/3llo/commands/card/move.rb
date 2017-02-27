module Tr3llo
  module Command
    module Card
      class MoveCommand
        def initialize(card_id, list_id, board_id)
          @card_id = card_id
          @list_id = list_id
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            prompt_for_list_id!(board_id) unless list_id
            move_card!
            interface.puts("Card has been moved.")
          end
        end

        private

        attr_reader :list_id, :card_id, :board_id

        def prompt_for_list_id!(board_id)
          board_id = $container.resolve(:board)[:id]
          lists = Tr3llo::API::List.find_all_by_board(board_id)

          @list_id =
            Tr3llo::Presenter::Card::MovePresenter
            .new(interface)
            .prompt_for_list_id(lists)
        end

        def move_card!
          API::Card.move_to_list(card_id, list_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
