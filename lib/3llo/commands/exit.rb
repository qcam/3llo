module Tr3llo
  module Command
    module ExitCommand
      extend self

      def execute
        Application.fetch_interface!().puts("Bye bye")
        exit
      end
    end
  end
end
