require "readline"

module Tr3llo
  module Controller
    extend self

    def start(init_command)
      Readline.completion_append_character = " "
      Readline.completion_proc = lambda { |buffer|
        Command.generate_suggestions(buffer, Readline.line_buffer)
      }

      interface = Application.fetch_interface!()

      if init_command && init_command != ""
        init_commands = init_command.split(";")
        init_commands.each do |cmd|
          interface.puts("Executing " + Utils.format_highlight(cmd) + " command")
          execute_command!(cmd)
        end
      end

      loop do
        status_line = determine_status_line()
        command_buffer = Readline.readline(status_line, true)
        Command::Exit.execute() if command_buffer.nil?

        execute_command!(command_buffer)
      end
    rescue Interrupt
      Command::Exit.execute()
    end

    private

    def determine_status_line()
      program_name = ["\e[15;48;5;27m 3llo \e[0m"]
      board_name =
        begin
          ["\e[45m #{Application.fetch_board!().name} \e[0m"]
        rescue BoardNotSelectedError
          []
        end

      (program_name + board_name + [""]).join(" > ")
    end

    def execute_command!(command_buffer)
      Tr3llo::Command.execute(command_buffer.strip())
    end
  end
end
