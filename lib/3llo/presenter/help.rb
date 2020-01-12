module Tr3llo
  module Presenter
    module HelpPresenter
      extend self

      def render()
        <<~TEMPLATE.strip
        #{Utils.format_bold(Utils.paint("3llo v#{Tr3llo::VERSION} - Interactive CLI application for Trello", "blue"))}


        #{Presenter::Board::Help.render()}

        #{Presenter::Card::Help.render()}

        #{Presenter::List::Help.render()}

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
