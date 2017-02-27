module Tr3llo
  module Command
    class HelpCommand
      def execute
        Presenter::HelpPresenter.new(interface).print!
      end

      private

      def interface
        $container.resolve(:interface)
      end
    end
  end
end
