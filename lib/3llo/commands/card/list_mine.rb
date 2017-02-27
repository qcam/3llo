module Tr3llo
  module Command
    module Card
      class ListMineCommand
        def initialize(board_id, user_id)
          @board_id = board_id
          @user_id = user_id
        end

        def execute
          Tr3llo::Presenter::Card::ListMinePresenter
            .new(interface)
            .print!(load_cards)
        end

        private

        attr_reader :board_id, :user_id

        def load_cards
          API::Card.find_all_by_user(board_id, user_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
