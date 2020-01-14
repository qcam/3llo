module Tr3llo
  module Command
    module Card
      module CheckItem
        extend self

        def execute(card_key, check_item_key)
          card_id = Entities.parse_id(:card, card_key)
          check_item_id = Entities.parse_id(:check_item, check_item_key)

          API::Checklist.update_item(card_id, check_item_id, state: "complete")

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts("Item has been checked")
          end
        end
      end
    end
  end
end
