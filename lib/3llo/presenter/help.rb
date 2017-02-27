module Tr3llo
  module Presenter
    class HelpPresenter
      def initialize(interface)
        @interface = interface
      end

      def print!
        interface.print_frame do
          interface.puts menu_text
        end
      end

      private

      attr_reader :interface

      def menu_text
        %q{
    3llo - CLI for Trello

    Usage:
    board list                      - Show list of board
    board select <board_id>         - Select board
    card list                       - Show list of cards grouped by list
    card list mine                  - Show list of my cards
    card show <card_id>             - Show card information
    card move <card_id> <list_id>   - Move card to a list
    card self-assign <card_id>      - Self-assign a card
    list list                       - Show all lists
    help                            - Show help menu
    exit                            - Exit program
        }
      end
    end
  end
end
