module Tr3llo
  module API
    module User
      extend self

      def find(user_id)
        url = "/members/#{user_id}"

        make_struct(
          JSON.parse(
            client.get(
              url,
              key: key,
              token: token
            )
          )
        )
      end

      def find_all_by_board(board_id)
        url = "/board/#{board_id}/members"

        JSON.parse(
          client.get(
            url,
            key: key,
            token: token
          )
        ).map do |user_payload|
          make_struct(user_payload)
        end
      end

      private

      def make_struct(payload)
        id, username = payload.fetch_values("id", "username")
        shortcut = Entities.make_shortcut(:user, id)

        Entities::User.new(id, shortcut, username)
      end

      def key
        Application.fetch_configuration!().api_key
      end

      def token
        Application.fetch_configuration!().api_token
      end

      def client
        Application.fetch_client!()
      end
    end
  end
end
