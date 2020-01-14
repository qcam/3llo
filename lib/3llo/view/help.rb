module Tr3llo
  module View
    module Help
      extend self

      def render()
        <<~TEMPLATE.strip
        #{Utils.format_bold(Utils.paint("3llo v#{Tr3llo::VERSION} - Interactive CLI application for Trello", "blue"))}


        #{View::Board::Help.render()}

        #{View::Card::Help.render()}

        #{View::List::Help.render()}

        #{miscellaneous_help()}
        TEMPLATE
      end

      def miscellaneous_help()
        <<~TEMPLATE.strip
        #{Utils.format_bold("# Miscellaneous commands:")}

        help  - Display this help message
        exit  - Exit the program
        TEMPLATE
      end
    end
  end
end
