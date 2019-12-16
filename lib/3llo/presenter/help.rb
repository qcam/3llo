# frozen_string_literal: true

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
          text = text.split("\n").map(&:lstrip).drop(1).join("\n") if @stripped
          interface.puts text
        end
      end

      private

      attr_reader :interface

      def menu_text(cli_help = false)
        cli_help_text = '
          This is an interactive program for trello cards. To start, you
          need to set `TRELLO_USER`, `TRELL_KEY` and `TRELLO_TOKEN` to access
          your account. After that, the following commands are available in interactive
          mode:
        '
        %(
    3llo - CLI for Trello 1.1y
    #{cli_help_text if cli_help}
    Usage:
    board list or b l            - Show list of board
    board select or b s          - Select board from a list
    card list or c l             - Show list of cards grouped by list
    card list mine               - Show list of my cards
    card add or c a              - Create a card
    card show or c s             - Show card information
    card edit or c e             - Edit card information
    card move or c m             - Move card to a list
    card self-assign or c sa     - Self-assign a card
    card assign or c asg         - Assign a user to a card
    card comments or c cs        - Load recent comments of a card
    card comment or c c          - Add a comment to a card
    card archive or c ar         - Archive a card
    list list or l l             - Show all lists
    list cards or l cs           - Show all cards in list
    list archive-cards <list_id> - Archive all cards in list
    help                         - Show help menu
    exit                         - Exit program
        )
      end
    end
  end
end
