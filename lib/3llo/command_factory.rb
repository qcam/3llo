require '3llo/board_command_factory'
require '3llo/card_command_factory'
require '3llo/list_command_factory'
require '3llo/commands/help'
require '3llo/commands/exit'
require '3llo/commands/invalid'

module Tr3llo
  module CommandFactory
    extend self

    def execute(command_buffer)
      build_command(command_buffer)
    end

    private

    def build_command(command_string)
      command, subcommand, *args = parse_command(command_string)

      case command
      when 'board'
        BoardCommandFactory.execute(subcommand, args)
      when 'card'
        CardCommandFactory.execute(subcommand, args)
      when 'list'
        ListCommandFactory.execute(subcommand, args)
      when 'help'
        Command::HelpCommand.execute()
      when 'exit'
        Command::ExitCommand.execute()
      else
        if command
          raise InvalidCommandError.new("#{command.inspect} is not a valid command. Run #{"help".inspect} to display the document.")
        else
          raise InvalidCommandError.new("command is missing")
        end
      end
    rescue InvalidCommandError => exception
      Command::InvalidCommand.execute(exception.message)
    end

    def parse_command(command_string)
      command_string.strip.split(' ')
    end
  end
end
