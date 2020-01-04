require 'readline'

module Tr3llo
  module Controller
    extend self

    def start
      list = %w(board card help list mine move select self-assign show)
      auto_completion = proc { |s| list.grep( /^#{Regexp.escape(s)}/ ) }

      Readline.completion_append_character = " "
      Readline.completion_proc = auto_completion

      while command_buffer = Readline.readline("\e[15;48;5;27m 3llo \e[0m > ", true)
        begin
          Tr3llo::CommandFactory.execute(command_buffer)
        rescue Tr3llo::HTTP::Client::RequestError => e
          interface.print_frame { interface.puts(e.message) }
        end
      end
    rescue Interrupt
      Command::ExitCommand.new.execute
    end

    private

    def interface
      $container.resolve(:interface)
    end
  end
end
