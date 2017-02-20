module Tr3llo
  class Interface
    def initialize(input, output)
      @input, @output = input, output
    end

    def print_frame
      print_line("")
      yield
      print_line("")
    end

    def print_line(str)
      output.puts(str)
    end
    alias :puts :print_line

    def print(str)
      output.print(str)
    end

    attr_reader :input, :output
  end
end
