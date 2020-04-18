module Tr3llo
  module Command
    module Board
      module Add
        extend self

        def execute()
          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Name:", required: true)
            desc = interface.input.ask("Description:")

            default_lists =
              interface.input.yes?("With default set of lists to the board (To Do, Doing, Done)?") do |question|
                question.default false
                question.positive "Y"
                question.negative "N"
              end

            API::Board.create(name: name, desc: desc, default_lists: default_lists)

            interface.puts("Board has been created.")
          end
        end
      end
    end
  end
end
