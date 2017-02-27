module Tr3llo
  module API
    module Card
      extend self

      def find_all_by_board(board_id)
        JSON.parse(
          client.get(
            "/boards/#{board_id}/cards",
            key: api_key,
            token: api_token,
          ),
          symbolize_names: true
        )
      end

      def find_all_by_list(list_id)
        JSON.parse(
          client.get(
            "/lists/#{list_id}/cards",
            key: api_key,
            token: api_token,
          ),
          symbolize_names: true
        )
      end

      def find_all_by_user(board_id, user_id)
        JSON.parse(
          client.get(
            "/boards/#{board_id}/members/#{user_id}/cards",
            list: true,
            key: api_key,
            token: api_token,
          ),
          symbolize_names: true
        )
      end

      def find(card_id)
        JSON.parse(
          client.get(
            "/cards/#{card_id}",
            list: true,
            key: api_key,
            token: api_token,
          ),
          symbolize_names: true
        )
      end

      def move_to_list(card_id, list_id)
        url = "/cards/#{card_id}/idList"
        JSON.parse(
          client.put(
            url,
            key: api_key,
            token: api_token,
            value: list_id
          ),
          symbolize_names: true
        )
      end

      def assign_members(card_id, members)
        url = "/cards/#{card_id}/idMembers"
        JSON.parse(
          client.put(
            url,
            key: api_key,
            token: api_token,
            value: members.join(',')
          ),
          symbolize_names: true
        )
      end

      private

      def api_key
        $container.resolve(:configuration).api_key
      end

      def api_token
        $container.resolve(:configuration).api_token
      end

      def client
        $container.resolve(:api_client)
      end
    end
  end
end
