module Tr3llo
  module Command
    module Card
      module RemoveChecklistCommand
        extend self

        def execute(checklist_key)
          checklist_id = Entities.parse_id(:checklist, checklist_key)
          API::Checklist.delete(checklist_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts("Checklist has been removed")
          end
        end
      end
    end
  end
end
