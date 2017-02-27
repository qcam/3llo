module Tr3llo
  module Command
    class InvalidCommand
      def execute
        interface.print_frame do
          interface.puts("Invalid command!".red)
          Presenter::HelpPresenter.new(interface).print!
        end
      end

      private

      def interface
        $container.resolve(:interface)
      end
    end
  end
end
