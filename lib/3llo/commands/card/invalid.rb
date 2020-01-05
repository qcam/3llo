module Tr3llo
  module Command
    module Card
      module InvalidCommand
        extend self

        def execute(message)
          interface.print_frame do
            interface.puts(message.red)
            interface.puts(menu_text)
          end
        end

        private

        def menu_text
          %q{
    Available `card` commands:

    card list               - Show list of cards grouped by list
    card list mine          - Show list of my cards
    card add                - Create a card
    card show <key>         - Show card information
    card move <key>         - Move card to a list
    card self-assign <key>  - Self-assign a card
    card assign <key>       - Assign a user to a card
    card comments <key>     - Load recent comments of a card
    card comment <key>      - Add a comment to a card
    card archive <key>      - Archive a card
          }
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
