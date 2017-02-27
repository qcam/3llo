module Tr3llo
  module Command
    module Card
      class ListCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          lists = load_lists

          lists.each do |list|
            Tr3llo::Presenter::Card::ListPresenter
              .new(interface)
              .print!(list, load_cards(list[:id]))
          end
        end

        private

        attr_reader :board_id

        def load_lists
          API::List.find_all_by_board(board_id)
        end

        def load_cards(list_id)
          API::Card.find_all_by_list(list_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
