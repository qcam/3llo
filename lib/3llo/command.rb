require "3llo/command/board"
require "3llo/command/card"
require "3llo/command/list"
require "3llo/command/help"
require "3llo/command/exit"
require "3llo/command/invalid"

module Tr3llo
  module Command
    extend self

    def execute(command_buffer)
      build_command(command_buffer)
    end

    private

    def build_command(command_string)
      command, subcommand, *args = parse_command(command_string)

      case command
      when "board"
        Command::Board.execute(subcommand, args)
      when "card"
        Command::Card.execute(subcommand, args)
      when "list"
        Command::List.execute(subcommand, args)
      when "help"
        Command::Help.execute()
      when "exit"
        Command::Exit.execute()
      else
        if command
          raise InvalidCommandError.new(
            "#{command.inspect} is not a valid command. Run #{"help".inspect} to display the document."
          )
        else
          raise InvalidCommandError.new("command is missing")
        end
      end
    rescue InvalidCommandError, RemoteServer::RequestError => exception
      Command::Invalid.execute(exception.message)
    end

    def parse_command(command_string)
      command_string.strip.split(" ")
    end
  end
end
