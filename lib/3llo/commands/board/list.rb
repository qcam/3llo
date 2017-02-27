module Tr3llo
  module Command
    module Board
      class ListCommand
        def initialize(user_id)
          @user_id = user_id
        end

        def execute
          Tr3llo::Presenter::Board::ListPresenter
            .new(interface)
            .print!(list_boards)
        end

        private

        attr_reader :user_id

        def list_boards
          API::Board.find_all_by_user(user_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
