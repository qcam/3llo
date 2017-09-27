module Tr3llo
  module Command
    module Card
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
    Available `card` commands

    card list                   - Show list of cards grouped by list
    card list mine              - Show list of my cards
    card add                    - Create a card
    card show <card_id>         - Show card information
    card move <card_id>         - Move card to a list
    card self-assign <card_id>  - Self-assign a card
    card assign <card_id>       - Assign a card to a user
    card comments <card_id>     - Load recent comments of a card
    card comment <card_id>      - Add a comment to a card
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
