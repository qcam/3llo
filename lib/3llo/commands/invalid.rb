module Tr3llo
  module Command
    module InvalidCommand
      extend self

      def execute(message)
        interface = Application.fetch_interface!()

        interface.print_frame do
          interface.puts(message.red)
          Presenter::HelpPresenter.print!(interface)
        end
      end
    end
  end
end
