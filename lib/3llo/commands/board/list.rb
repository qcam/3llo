module Tr3llo
  module Command
    module Board
      module ListCommand
        extend self

        def execute(user_id)
          boards = get_boards(user_id)

          Tr3llo::Presenter::Board::ListPresenter
            .new(interface)
            .print!(boards)
        end

        private

        def get_boards(user_id)
          API::Board.find_all_by_user(user_id)
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
