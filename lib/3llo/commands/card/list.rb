module Tr3llo
  module Command
    module Card
      module ListCommand
        extend self

        def execute(board_id)
          lists = get_lists(board_id)

          lists.each do |list|
            cards = get_cards(list[:id])

            Tr3llo::Presenter::Card::ListPresenter
              .new(interface)
              .print!(list, cards)
          end
        end

        private

        attr_reader :board_id

        def get_lists(board_id)
          API::List.find_all_by_board(board_id)
        end

        def get_cards(list_id)
          API::Card.find_all_by_list(list_id)
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
