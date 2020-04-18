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

            default_lists = interface.input.yes?("Create a default lists (To Do, Doing, Done) on this board?") do |q|
              q.default false
              q.positive "Y"
              q.negative "N"
            end

            API::Board.create(name: name, desc: desc, default_lists: default_lists)

            interface.puts("Board has been created.")
          end
        end
      end
    end
  end
end
