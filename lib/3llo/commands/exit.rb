module Tr3llo
  module Command
    class ExitCommand
      def execute
        interface.puts("Bye bye")
        exit(0)
      end

      private

      def interface
        $container.resolve(:interface)
      end
    end
  end
end
