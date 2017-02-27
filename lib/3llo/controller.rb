require 'readline'

module Tr3llo
  class Controller
    def initialize
    end

    def start
      list = %w(board card help list mine move select self-assign show)
      comp = proc { |s| list.grep( /^#{Regexp.escape(s)}/ ) }

      Readline.completion_append_character = " "
      Readline.completion_proc = comp
      loop do
        command_buffer = Readline.readline("\e[15;48;5;27m 3llo \e[0m > ", true)
        begin
          Tr3llo::CommandFactory
            .new(command_buffer)
            .factory
            .execute
        rescue Tr3llo::Client::RequestError => e
          interface.print_frame { interface.puts(e.message) }
        end
      end
    rescue Interrupt
      interface.print_frame { interface.puts('Bye Bye...') }
    end

    private

    def interface
      $container.resolve(:interface)
    end
  end
end
