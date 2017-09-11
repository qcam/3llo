module Tr3llo
  module Command
    module Card
      class AddCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            list_id = interface.input.select(
              "Choose a list:",
              load_lists
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

        attr_reader :board_id

        
        def create_card!(name, description, list_id)
          API::Card.create(name, description, list_id)
        end

        def load_lists
          API::List
            .find_all_by_board(board_id)
            .map { |list| [list[:name], list[:id]] }
            .to_h
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
