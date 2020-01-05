module Tr3llo
  module API
    module List
      extend self

      def find_all_by_board(board_id)
        JSON.parse(
          client.get(
            "/boards/#{board_id}/lists/",
            list: true,
            key: api_key,
            token: api_token
          )
        ).map do |list_payload|
          make_struct(list_payload)
        end
      end

      def archive_cards(list_id)
        JSON.parse(
          client.post(
            "/lists/#{list_id}/archiveAllCards",
            key: api_key,
            token: api_token
          )
        )
      end

      private

      def make_struct(payload)
        id, name = payload.fetch_values("id", "name")
        shortcut = Entities.make_shortcut(:list, id)

        Entities::List.new(id, shortcut, name)
      end

      def client
        Application.fetch_client!()
      end

      def api_key
        Application.fetch_configuration!().api_key
      end

      def api_token
        Application.fetch_configuration!().api_token
      end
    end
  end
end
