module Tr3llo
  module Command
    module HelpCommand
      extend self

      def execute
        Presenter::HelpPresenter.print!(Application.fetch_interface!())
      end
    end
  end
end
