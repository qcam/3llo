module Tr3llo
  module API
    module Checklist
      extend self

      def create(card_id, data)
        req_path = Utils.build_req_path("/cards/#{card_id}/checklists")

        client.post(req_path, {}, data)
      end

      def get(checklist_id)
        req_path = Utils.build_req_path("/checklists/#{checklist_id}")
        payload = client.get(req_path, {})

        checklist_id, checklist_name = payload.fetch_values("id", "name")
        checklist_shortcut = Entities.make_shortcut(:checklist, checklist_id)

        Entities::Checklist.new(
          id: checklist_id,
          shortcut: checklist_shortcut,
          name: checklist_name,
          items: []
        )
      end

      def update(checklist_id, data)
        req_path = Utils.build_req_path("/checklists/#{checklist_id}")

        client.put(req_path, {}, data)
      end

      def delete(checklist_id)
        req_path = Utils.build_req_path("/checklists/#{checklist_id}")

        client.delete(req_path, {}, {})
      end

      def list_by_card_id(card_id)
        req_path = Utils.build_req_path("/cards/#{card_id}/checklists")
        payload = client.get(req_path, {})

        payload.map do |checklist_payload|
          checklist_id, checklist_name = checklist_payload.fetch_values("id", "name")
          checklist_shortcut = Entities.make_shortcut(:checklist, checklist_id)

          items =
            checklist_payload
              .fetch("checkItems", [])
              .map do |item_payload|
              item_id, item_name, item_state = item_payload.fetch_values("id", "name", "state")
              item_shortcut = Entities.make_shortcut(:check_item, item_id)

              Entities::Checklist::Item.new(id: item_id, shortcut: item_shortcut, name: item_name, state: item_state)
            end

          Entities::Checklist.new(
            id: checklist_id,
            shortcut: checklist_shortcut,
            name: checklist_name,
            items: items
          )
        end
      end

      def get_item(card_id, item_id)
        req_path = Utils.build_req_path("/cards/#{card_id}/checkItem/#{item_id}")
        item_payload = client.get(req_path, {})

        item_id, item_name, item_state = item_payload.fetch_values("id", "name", "state")
        item_shortcut = Entities.make_shortcut(:check_item, item_id)

        Entities::Checklist::Item.new(id: item_id, shortcut: item_shortcut, name: item_name, state: item_state)
      end

      def create_item(checklist_id, name)
        req_path = Utils.build_req_path("/checklists/#{checklist_id}/checkItems")
        payload = {
          name: name,
          pos: "bottom",
          state: "false"
        }

        client.post(req_path, {}, payload)
      end

      def update_item(card_id, check_item_id, data)
        req_path = Utils.build_req_path("/cards/#{card_id}/checkItem/#{check_item_id}")

        client.put(req_path, {}, data)
      end

      def delete_item(card_id, item_id)
        req_path = Utils.build_req_path("/cards/#{card_id}/checkItem/#{item_id}")

        client.delete(req_path, {}, {})
      end

      private

      def client
        Application.fetch_client!()
      end
    end
  end
end
