module Tr3llo
  module Command
    module List
      module ListCommand
        extend self

        def execute(board_id)
          lists = list_lists(board_id)

          Tr3llo::Presenter::List::ListPresenter
            .new(interface)
            .print!(lists)
        end

        private

        def list_lists(board_id)
          API::List.find_all_by_board(board_id)
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
