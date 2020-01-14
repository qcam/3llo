module Tr3llo
  module Command
    module List
      module Invalid
        extend self

        def execute(message)
          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.print_error(message)
            interface.puts(Presenter::List::Help.render())
          end
        end
      end
    end
  end
end
