module Tr3llo
  module Presenter
    class HelpPresenter
      def initialize(interface, stripped = false)
        @interface = interface
        @stripped = stripped
      end

      def print!
        interface.print_frame do
          text = menu_text(@stripped)
          if @stripped
            text = text.split("\n").map(&:lstrip).drop(1).join("\n")
          end
          interface.puts text
        end
      end

      private

      attr_reader :interface

      def menu_text(cli_help = false)
        cli_help_text = %q{
          This is an interactive program for trello cards. To start, you
          need to set `TRELLO_USER`, `TRELL_KEY` and `TRELLO_TOKEN` to access
          your account. After that, the following commands are available in interactive
          mode:
        }
        %Q{
    3llo - CLI for Trello 1.1
    #{if cli_help then cli_help_text end}
    Usage:
    board list                   - Show list of board
    board select                 - Select board
    card list                    - Show list of cards grouped by list
    card list mine               - Show list of my cards
    card add                     - Create a card
    card show <card_id>          - Show card information
    card edit <card_id>          - Edit card information
    card move <card_id>          - Move card to a list
    card self-assign <card_id>   - Self-assign a card
    card assign <card_id>        - Assign a user to a card
    card comments <card_id>      - Load recent comments of a card
    card comment <card_id>       - Add a comment to a card
    card archive <card_id>       - Archive a card
    list list                    - Show all lists
    list cards <list_id>         - Show all cards in list
    list archive-cards <list_id> - Archive all cards in list
    help                         - Show help menu
    exit                         - Exit program
        }
      end
    end
  end
end
