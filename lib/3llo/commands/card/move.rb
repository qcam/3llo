# frozen_string_literal: true

module Tr3llo
  module Command
    module Card
      class MoveCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            SharedFunctions.load_lists(@board_id)
            card = SharedFunctions.load_card(SharedFunctions.select_card)
            card_id = card[:id]

            list_id = SharedFunctions.load_lists(@board_id)
            move_card!(card_id, list_id)
            interface.puts('The card has been moved.')
          end
        end

        private

        attr_reader :board_id

        def move_card!(card_id, list_id)
          API::Card.move_to_list(card_id, list_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
