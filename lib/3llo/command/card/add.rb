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

          Utils.assert_list!(list_options)

          interface = Application.fetch_interface!()

          interface.print_frame do
            list_id = interface.input.select(
              "Choose the list this card should belong to:",
              list_options
            )

            name = interface.input.ask("Name:", required: true)
            description = interface.input.ask("Description:")

            API::Card.create(name, description, list_id)

            interface.puts("Card has been created.")
          end
        end
      end
    end
  end
end
