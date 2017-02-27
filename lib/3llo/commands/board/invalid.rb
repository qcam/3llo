module Tr3llo
  module Command
    module Board
      class InvalidCommand
        def execute
          interface.print_frame do
            interface.puts("Invalid command".red)
            interface.puts(menu_text)
          end
        end

        private

        def menu_text
          %q{
    Available `board` commands

    board list                      - Show list of board
    board select <board_id>         - Select board
          }
        end

        def container
          $container
        end

        def interface
          container.resolve(:interface)
        end
      end
    end
  end
end
