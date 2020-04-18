require "3llo/command/board"
require "3llo/command/card"
require "3llo/command/list"
require "3llo/command/label"
require "3llo/command/help"
require "3llo/command/exit"
require "3llo/command/invalid"

module Tr3llo
  module Command
    extend self

    def execute(command_buffer)
      build_command(command_buffer)
    end

    def generate_suggestions(buffer, command_buffer)
      commands = {
        "board" => %w[add list select],
        "list" => %w[list add cards archive-cards],
        "card" => %w[
          list show add edit archive list-mine move
          comment comments self-assign assign
          add-checklist edit-checklist remove-checklist
          add-item edit-item remote-item check-item uncheck-item
        ],
        "label" => %w[list add edit remove],
        "help" => [],
        "exit" => []
      }

      command, _subcommand, _args = parse_command(command_buffer)

      if commands.has_key?(command)
        subcommands = commands.fetch(command)

        subcommands
          .grep(/^#{Regexp.escape(buffer)}/)
          .reject { |suggestion| suggestion == buffer }
      else
        commands.keys.grep(/^#{Regexp.escape(buffer)}/)
      end
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
      when "label"
        Command::Label.execute(subcommand, args)
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
      command_string.strip.split(" ").map(&:strip)
    end
  end
end
