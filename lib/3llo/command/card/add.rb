module Tr3llo
  module Command
    module Card
      module Add
        extend self

        def execute(board_id)
          list_options =
            API::List
              .find_all_by_board(board_id)
              .map { |list| [list.name, list.id] }
              .to_h()

          interface = Application.fetch_interface!()

          interface.print_frame do
            if list_options.any?
              list_id = interface.input.select(
                "Choose the list this card should belong to:",
                list_options
              )

              name = interface.input.ask("Name:", required: true)
              description = interface.input.multiline("Description:").join("")

              API::Card.create(name, description, list_id)

              interface.puts("Card has been created.")
            else
              interface.puts("There is no list on board.")
            end
          end
        end
      end
    end
  end
end
