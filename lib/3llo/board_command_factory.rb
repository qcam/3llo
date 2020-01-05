require '3llo/commands/board/list'
require '3llo/commands/board/select'
require '3llo/commands/board/invalid'

module Tr3llo
  module BoardCommandFactory
    extend self

    def execute(subcommand, args)
      case subcommand
      when 'list'
        user = Application.fetch_user!()

        Command::Board::ListCommand.execute(user[:id])
      when 'select'
        board_key, _ = args
        Utils.assert_string!(board_key, "board key is missing")
        
        Command::Board::SelectCommand.execute(board_key)
      else
        handle_invalid_subcommand(subcommand, args)
      end
    rescue InvalidCommandError => exception
      Command::Board::InvalidCommand.execute(exception.message)
    rescue InvalidArgumentError => exception
      Command::Board::InvalidCommand.execute(exception.message)
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
