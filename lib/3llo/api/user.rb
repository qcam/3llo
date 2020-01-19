module Tr3llo
  module API
    module User
      extend self

      def find(user_id)
        client = Application.fetch_client!()
        req_path = Utils.build_req_path("/members/#{user_id}")

        make_struct(client.get(req_path, {}))
      end

      def find_all_by_board(board_id)
        client = Application.fetch_client!()
        req_path = Utils.build_req_path("/board/#{board_id}/members")

        client
          .get(req_path, {})
          .map { |user_payload| make_struct(user_payload) }
      end

      private

      def make_struct(payload)
        id, username = payload.fetch_values("id", "username")
        shortcut = Entities.make_shortcut(:user, id)

        Entities::User.new(id, shortcut, username)
      end
    end
  end
end
