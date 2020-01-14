module Tr3llo
  module Command
    module Card
      module AddItem
        extend self

        def execute(checklist_key)
          checklist_id = Entities.parse_id(:checklist, checklist_key)
          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Item name:", required: true)

            API::Checklist.create_item(checklist_id, name)

            interface.puts("Item #{name.inspect} has been added")
          end
        end
      end
    end
  end
end
