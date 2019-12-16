# frozen_string_literal: true

module Tr3llo
  module Command
    module Card
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
    Available `card` commands

    card list or c l            - Show list of cards grouped by list
    card list mine              - Show list of my cards
    card add  or c a            - Create a card
    card show or c s            - Show card information
    card move or c m            - Move card to a list
    card self-assign or c sa    - Self-assign a card
    card assign or c asg        - Assign a user to a card
    card comments or c cs       - Load recent comments of a card
    card comment or c c         - Add a comment to a card
    card archive <card_id>      - Archive a card
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
