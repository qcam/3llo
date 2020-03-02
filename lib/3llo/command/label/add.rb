module Tr3llo
  module Command
    module Label
      module Add
        extend self

        def execute(board_id)
          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Name:", required: true)
            color = interface.input.select("Choose the color:", Utils::TRELLO_LABEL_COLOR)

            API::Label.create(name: name, color: color, board_id: board_id)

            interface.puts("Label has been created.")
          end
        end
      end
    end
  end
end
