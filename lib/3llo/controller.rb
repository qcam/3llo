require "readline"

module Tr3llo
  module Controller
    extend self

    def start(init_command)
      Readline.completion_append_character = "   "
      Readline.completion_proc = lambda { |buffer|
        Command.generate_suggestions(buffer, Readline.line_buffer)
      }

      interface = Application.fetch_interface!()

      if init_command && init_command != ""
        interface.puts("Executing " + Utils.format_highlight(init_command) + " command")

        execute_command!(init_command)
      end

      loop do
        command_buffer = Readline.readline("\e[15;48;5;27m 3llo \e[0m > ", true)

        execute_command!(command_buffer)
      end
    rescue Interrupt
      Command::Exit.execute()
    end

    private

    def execute_command!(command_buffer)
      Tr3llo::Command.execute(command_buffer.strip())
    end
  end
end
