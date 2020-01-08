module Tr3llo
  module Command
    module Board
      module InvalidCommand
        extend self

        def execute(message = "invalid command")
          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts(message.red)
            interface.puts(menu_text)
          end
        end

        private

        def menu_text
          %q{
    Available `board` commands:

    board list         - Show list of boards
    board select <key> - Select board
          }
        end
      end
    end
  end
end
