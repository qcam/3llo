require '3llo/board_command_factory'
require '3llo/card_command_factory'
require '3llo/list_command_factory'
require '3llo/commands/help'
require '3llo/commands/exit'
require '3llo/commands/invalid'
require '3llo/commands/error'

module Tr3llo
  class CommandFactory
    def initialize(command_buffer)
      @command_buffer = command_buffer
    end

    def factory
      command, subcommand, *args = command_buffer.strip.split(' ')

      case command
      when 'board'
        BoardCommandFactory.new(subcommand, args).factory
      when 'card'
        CardCommandFactory.new(subcommand, args).factory
      when 'list'
        ListCommandFactory.new(subcommand, args).factory
      when 'help', ''
        Command::HelpCommand.new
      when 'exit'
        Command::ExitCommand.new
      else
        Command::InvalidCommand.new
      end
    rescue Container::KeyNotFoundError
      Command::ErrorCommand.new
    end

    private

    attr_reader :command_buffer
  end
end
