module Tr3llo
  module Command
    module Card
      module EditItemCommand
        extend self

        def execute(card_key, item_key)
          card_id = Entities.parse_id(:card, card_key)
          item_id = Entities.parse_id(:check_item, item_key)

          item = API::Checklist.get_item(card_id, item_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Item name:", required: true, value: item.name)

            API::Checklist.update_item(card_id, item_id, name: name)

            interface.puts("Item has been updated")
          end
        end
      end
    end
  end
end
