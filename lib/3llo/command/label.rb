require "3llo/command/label/list"
require "3llo/command/label/invalid"
require "3llo/command/label/edit"

module Tr3llo
  module Command
    module Label
      extend self

      def execute(subcommand, args)
        case subcommand
        when "list"
          board = Application.fetch_board!()

          Command::Label::List.execute(board[:id])
        when "edit"
          label_key, = args
          Utils.assert_string!(label_key, "label key is missing")

          Command::Label::Edit.execute(label_key)
        # when "archive-cards"
        #   list_key, = args
        #   Utils.assert_string!(list_key, "list key is missing")

        #   Command::List::ArchiveCards.execute(list_key)
        else
          handle_invalid_subcommand(subcommand, args)
        end
      rescue InvalidArgumentError, InvalidCommandError, BoardNotSelectedError => exception
        Command::Label::Invalid.execute(exception.message)
      end

      private

      def handle_invalid_subcommand(subcommand, _args)
        case subcommand
        when String
          raise InvalidCommandError.new("#{subcommand.inspect} is not a valid command")
        when NilClass
          raise InvalidCommandError.new("command is missing")
        end
      end
    end
  end
end