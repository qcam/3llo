module Tr3llo
  class Interface
    def initialize(input, output)
      @input, @output = input, output
    end

    def print_frame
      print_line("")
      data = yield
      print_line("")
      data
    end

    def print_line(str)
      output.puts(str)
    end
    alias :puts :print_line

    def print(str)
      output.print(str)
    end

    def prompt(message)
      print("Enter list ID to be moved to: ")
      input.gets.chomp
    end

    attr_reader :input, :output
  end
end
