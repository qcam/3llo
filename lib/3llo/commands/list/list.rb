module Tr3llo
  module Command
    module List
      class ListCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          Tr3llo::Presenter::List::ListPresenter
            .new(interface)
            .print!(list_lists)
        end

        private

        attr_reader :board_id

        def list_lists
          API::List.find_all_by_board(board_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
