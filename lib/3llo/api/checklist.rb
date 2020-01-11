module Tr3llo
  module API
    module Checklist
      extend self

      def list_by_card_id(card_id)
        payload =
          JSON.parse(
            client.get(
              "/cards/#{card_id}/checklists",
              key: api_key,
              token: api_token
            )
          )

        payload.map do |checklist_payload|
          checklist_id, checklist_name = checklist_payload.fetch_values("id", "name")

          items =
            checklist_payload
            .fetch("checkItems", [])
            .map do |check_item_payload|
              item_id, item_name, item_state = check_item_payload.fetch_values("id", "name", "state")

              Entities::Checklist::Item.new(id: item_id, name: item_name, state: item_state)
            end

          Entities::Checklist.new(id: checklist_id, name: checklist_name, items: items)
        end
      end

      private

      def api_key
        Application.fetch_configuration!().api_key
      end

      def api_token
        Application.fetch_configuration!().api_token
      end

      def client
        Application.fetch_client!()
      end
    end
  end
end
