module Tr3llo
  module Command
    module Card
      module ListMineCommand
        extend self

        def execute(board_id, user_id)
          cards = get_cards(board_id, user_id)

          Tr3llo::Presenter::Card::ListMinePresenter
            .new(interface)
            .print!(cards)
        end

        private

        def get_cards(board_id, user_id)
          API::Card.find_all_by_user(board_id, user_id)
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
