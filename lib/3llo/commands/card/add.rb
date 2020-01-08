module Tr3llo
  module Command
    module Card
      module AddCommand
        extend self

        def execute(board_id)
          lists = get_lists(board_id)

          list_options =
            lists
            .map { |list| [list[:name], list[:id]] }
            .to_h

          interface.print_frame do
            list_id = interface.input.select(
              "Choose a list:",
              list_options
            )

            name = interface.input.ask("Name:")
            description = interface.input.ask("Description:")

            interface.puts(
              create_card!(name, description, list_id) &&
              "Card created"
            )
          end
        end

        private

        def create_card!(name, description, list_id)
          API::Card.create(name, description, list_id)
        end

        def get_lists(board_id)
          API::List.find_all_by_board(board_id)
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
