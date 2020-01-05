module Tr3llo
  module API
    module Board
      extend self

      def find_all_by_user(user_id)
        JSON.parse(
          client.get(
            "/members/#{user_id}/boards",
            key: api_key,
            token: api_token,
            filter: "open"
          )
        ).map do |board_payload|
          make_struct(board_payload)
        end
      end

      def find(board_id)
        payload =
          JSON.parse(
            client.get(
              "/boards/#{board_id}",
              key: api_key,
              token: api_token,
            )
          )

        make_struct(payload)
      end

      private

      def client
        Application.fetch_client!()
      end

      def api_key
        Application.fetch_configuration!().api_key
      end

      def api_token
        Application.fetch_configuration!().api_token
      end

      def make_struct(payload)
        id, name = payload.fetch_values("id", "name")
        shortcut = Entities.make_shortcut(:board, id)

        Entities::Board.new(id, shortcut, name)
      end
    end
  end
end
