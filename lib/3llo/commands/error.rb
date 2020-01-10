module Tr3llo
  module Command
    class ErrorCommand
      def execute
        interface.print_frame do
          formatted_command = "board select".inspect
          interface.puts("You have not selected any board. Run #{formatted_command} to select one.")
        end
      end

      private

      def interface
        Application.fetch_interface!()
      end
    end
  end
end
