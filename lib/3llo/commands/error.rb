module Tr3llo
  module Command
    class ErrorCommand
      def execute
        interface.print_frame do
          command = "board select <board-id>".red
          interface.puts("You have not selected any board. Run #{command} to select one.")
        end
      end

      private

      def interface
        $container.resolve(:interface)
      end
    end
  end
end
