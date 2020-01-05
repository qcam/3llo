module Tr3llo
  module Presenter
    module HelpPresenter
      extend self

      def print!(interface)
        interface.print_frame do
          interface.puts(menu_text)
        end
      end

      def menu_text
        %Q{
    3llo - CLI for Trello

    Avaiable commands:

    board list               - Show list of board
    board select             - Select board
    card list                - Show list of cards grouped by list
    card list mine           - Show list of my cards
    card add                 - Create a card
    card show <key>          - Show card information
    card move <key>          - Move card to a list
    card self-assign <key>   - Self-assign a card
    card assign <key>        - Assign a user to a card
    card comments <key>      - Load recent comments of a card
    card comment <key>       - Add a comment to a card
    card archive <key>       - Archive a card
    list list                - Show all lists
    list cards <key>         - Show all cards in list
    list archive-cards <key> - Archive all cards in list
    help                     - Show help menu
    exit                     - Exit program
        }
      end
    end
  end
end
