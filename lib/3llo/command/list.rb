require '3llo/command/list/list'
require '3llo/command/list/cards'
require '3llo/command/list/invalid'
require '3llo/command/list/archive_cards'

module Tr3llo
  module Command
    module List
      extend self

      def execute(subcommand, args)
        case subcommand
        when 'list'
          board = Application.fetch_board!()

          Command::List::List.execute(board[:id])
        when 'cards'
          list_key, _ = args
          Utils.assert_string!(list_key, "list key is missing")

          Command::List::Cards.execute(list_key)
        when 'archive-cards'
          list_key, _ = args
          Utils.assert_string!(list_key, "list key is missing")

          Command::List::ArchiveCards.execute(list_key)
        else
          handle_invalid_subcommand(subcommand, args)
        end
      rescue InvalidArgumentError => exception
        Command::List::Invalid.execute(exception.message)
      rescue InvalidCommandError => exception
        Command::List::Invalid.execute(exception.message)
      rescue BoardNotSelectedError => exception
        Command::List::Invalid.execute(exception.message)
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
