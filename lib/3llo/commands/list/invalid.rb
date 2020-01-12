module Tr3llo
  module Command
    module List
      module InvalidCommand
        extend self

        def execute(message)
          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.print_error(message)
            interface.puts(Presenter::List::Help.render())
          end
        end

        private

        def menu_text
          %q{
    Available `list` commands:

    list list                   - Show all lists
    list cards <key>            - Show all cards in list
    list archive-cards <key>    - Archive all cards in list
          }
        end
      end
    end
  end
end
