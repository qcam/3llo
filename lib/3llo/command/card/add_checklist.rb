module Tr3llo
  module Command
    module Card
      module AddChecklist
        extend self

        def execute(card_key)
          card_id = Entities.parse_id(:card, card_key)
          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Checklist name:", required: true)

            API::Checklist.create(card_id, name: name)

            interface.puts("Item #{name.inspect} has been added")
          end
        end
      end
    end
  end
end
