require '3llo/commands/board/list'
require '3llo/commands/board/select'
require '3llo/commands/board/invalid'

module Tr3llo
  class BoardCommandFactory
    def initialize(subcommand, args)
      @subcommand = subcommand
      @args = args
    end

    def factory
      case subcommand.to_sym
      when :list
        user_id = $container.resolve(:user)[:id]
        Command::Board::ListCommand.new(user_id)
      when :select
        board_id, _ = args
        Command::Board::SelectCommand.new(board_id)
      else
        Command::Board::InvalidCommand.new
      end
    end

    private

    attr_reader :subcommand, :args
  end
end
