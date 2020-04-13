module Tr3llo
  module Command
    module List
      module Add
        extend self

        def execute(board_id)
          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Name:", required: true)

            API::List.create(name, board_id)

            interface.puts("List has been created.")
          end
        end
      end
    end
  end
end
