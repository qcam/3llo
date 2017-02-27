require '3llo/commands/list/list'
require '3llo/commands/list/invalid'

module Tr3llo
  class ListCommandFactory
    def initialize(subcommand, args)
      @subcommand = subcommand
      @args = args
    end

    def factory
      case subcommand.to_sym
      when :list
        board_id = $container.resolve(:board)[:id]
        Command::List::ListCommand.new(board_id)
      else
        Command::List::InvalidCommand.new
      end
    end

    private

    attr_reader :subcommand, :args
  end
end
