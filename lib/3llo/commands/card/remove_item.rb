module Tr3llo
  module Command
    module Card
      module RemoveItemCommand
        extend self

        def execute(card_key, item_key)
          card_id = Entities.parse_id(:card, card_key)
          item_id = Entities.parse_id(:check_item, item_key)
          API::Checklist.delete_item(card_id, item_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts("Item has been removed")
          end
        end
      end
    end
  end
end
