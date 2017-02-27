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
          interface.puts "[#{board[:id].labelize}] - #{board[:name]}"
        end
      end
    end
  end
end
