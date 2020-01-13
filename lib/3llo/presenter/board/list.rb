module Tr3llo
  module Presenter
    module Board
      module ListPresenter
        extend self

        def render(boards)
          boards
          .map { |board| render_board(board) }
          .join("\n")
        end

        private

        def render_board(board)
          "#{Utils.format_key_tag(board.id, board.shortcut)} - #{board.name}"
        end
      end
    end
  end
end
