module Tr3llo
  module Presenter
    module Board
      class ListPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(boards)
          interface.print_frame do
            boards.each { |board| present_board(board) }
          end
        end

        private

        attr_reader :interface

        def present_board(board)
          interface.puts(
            "#{Utils.format_key_tag(board.id, board.shortcut)} - #{board.name}"
          )
        end
      end
    end
  end
end
