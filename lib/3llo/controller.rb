require 'readline'

module Tr3llo
  module Controller
    extend self

    def start(init_command)
      list = %w(board card help list mine move select self-assign show)
      auto_completion = proc { |s| list.grep( /^#{Regexp.escape(s)}/ ) }

      Readline.completion_append_character = " "
      Readline.completion_proc = auto_completion

      interface = Application.fetch_interface!()

      if init_command && init_command != ""
        interface.puts("Executing " + init_command.yellow + " command")

        execute_command!(init_command, interface)
      end

      loop do
        command_buffer = Readline.readline("\e[15;48;5;27m 3llo \e[0m > ", true)

        execute_command!(command_buffer, interface)
      end
    rescue Interrupt
      Command::ExitCommand.execute()
    end

    def execute_command!(command_buffer, interface)
      Tr3llo::CommandFactory.execute(command_buffer.strip())
    rescue Tr3llo::HTTP::Client::RequestError => e
      interface.print_frame { interface.puts(e.message.red) }
    end
  end
end
