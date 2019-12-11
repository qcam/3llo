# frozen_string_literal: true

module Tr3llo
  module Command
    module List
      class InvalidCommand
        def execute
          interface.print_frame do
            interface.puts('Invalid command'.red)
            interface.puts(menu_text)
          end
        end

        private

        def menu_text
          '
    Available `list` commands

    list list                       - Show all lists
    list cards <list_id>            - Show all cards in list
    list archive-cards <list_id>    - Archive all cards in list
          '
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
