require "3llo/command/board/list"
require "3llo/command/board/select"
require "3llo/command/board/invalid"

module Tr3llo
  module Command
    module Board
      extend self

      def execute(subcommand, args)
        case subcommand
        when "list"
          user = Application.fetch_user!()

          Command::Board::List.execute(user[:id])
        when "select"
          board_key, = args
          Utils.assert_string!(board_key, "board key is missing")

          Command::Board::Select.execute(board_key)
        else
          handle_invalid_subcommand(subcommand, args)
        end
      rescue InvalidCommandError => exception
        Command::Board::Invalid.execute(exception.message)
      rescue InvalidArgumentError => exception
        Command::Board::Invalid.execute(exception.message)
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
