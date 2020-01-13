module Tr3llo
  module Command
    module Board
      module ListCommand
        extend self

        def execute(user_id)
          interface = Application.fetch_interface!()
          boards = API::Board.find_all_by_user(user_id)

          interface.print_frame do
            interface.puts(Presenter::Board::ListPresenter.render(boards))
          end
        end
      end
    end
  end
end
