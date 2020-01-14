module Tr3llo
  module Command
    module Card
      module EditChecklist
        extend self

        def execute(checklist_key)
          checklist_id = Entities.parse_id(:checklist, checklist_key)
          checklist = API::Checklist.get(checklist_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Checklist name:", required: true, value: checklist.name)

            API::Checklist.update(checklist_id, name: name)

            interface.puts("Checklist has been updated")
          end
        end
      end
    end
  end
end
