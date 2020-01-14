module Tr3llo
  module Command
    module Invalid
      extend self

      def execute(message)
        interface = Application.fetch_interface!()

        interface.print_frame do
          interface.print_error(message)
        end
      end
    end
  end
end
