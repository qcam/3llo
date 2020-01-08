module Tr3llo
  module Command
    class ErrorCommand
      def execute
        interface.print_frame do
          command = "board select".red
          interface.puts("You have not selected any board. Run #{command} to select one.")
        end
      end

      private

      def interface
        Application.fetch_interface!()
      end
    end
  end
end
