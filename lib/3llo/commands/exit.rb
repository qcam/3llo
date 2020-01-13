module Tr3llo
  module Command
    module ExitCommand
      extend self

      def execute
        interface = Application.fetch_interface!()

        interface.print_frame do
          interface.puts("Bye bye")
        end
        
        exit
      end
    end
  end
end
