module Tr3llo
  module Command
    module Board
      module ListCommand
        extend self

        def execute(user_id)
          interface = Application.fetch_interface!()
          boards = get_boards(user_id)

          interface.print_frame do
            interface.puts(Tr3llo::Presenter::Board::ListPresenter.render(boards))
          end
        end

        private

        def get_boards(user_id)
          API::Board.find_all_by_user(user_id)
        end
      end
    end
  end
end
