module Tr3llo
  module Command
    module Help
      extend self

      def execute
        interface = Application.fetch_interface!()

        interface.print_frame do
          interface.puts(Presenter::HelpPresenter.render())
        end
      end
    end
  end
end
