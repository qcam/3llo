module Tr3llo
  module API
    module Checklist
      extend self

      def create(card_id, data)
        params = data.merge(key: api_key, token: api_token)

        client.post("/cards/#{card_id}/checklists", params)
      end

      def get(checklist_id)
        payload =
          JSON.parse(
            client.get(
              "/checklists/#{checklist_id}",
              key: api_key,
              token: api_token
            )
          )

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
        params = data.merge(key: api_key, token: api_token)

        client.put("/checklists/#{checklist_id}", params)
      end

      def delete(checklist_id)
        client.delete("/checklists/#{checklist_id}", token: api_token, key: api_key)
      end

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
        item_payload =
          JSON.parse(
            client.get(
              "/cards/#{card_id}/checkItem/#{item_id}",
              key: api_key,
              token: api_token
            )
          )

        item_id, item_name, item_state = item_payload.fetch_values("id", "name", "state")
        item_shortcut = Entities.make_shortcut(:check_item, item_id)

        Entities::Checklist::Item.new(id: item_id, shortcut: item_shortcut, name: item_name, state: item_state)
      end

      def create_item(checklist_id, name)
        client.post(
          "/checklists/#{checklist_id}/checkItems",
          key: api_key,
          token: api_token,
          name: name,
          pos: "bottom",
          state: false
        )
      end

      def update_item(card_id, check_item_id, data)
        params = data.merge(key: api_key, token: api_token)

        client.put("/cards/#{card_id}/checkItem/#{check_item_id}", params)
      end

      def delete_item(card_id, item_id)
        client.delete("/cards/#{card_id}/checkItem/#{item_id}", token: api_token, key: api_key)
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
