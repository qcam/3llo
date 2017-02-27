module Tr3llo
  module Command
    module List
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

    list list                       - Show all lists
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
