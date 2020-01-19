module Tr3llo
  module API
    module Board
      extend self

      def find_all_by_user(user_id)
        client = Application.fetch_client!()
        req_path =
          Utils.build_req_path(
            "/members/#{user_id}/boards",
            {"filter" => "open"}
          )

        client
          .get(req_path, {})
          .map do |board_payload|
            make_struct(board_payload)
          end
      end

      def find(board_id)
        client = Application.fetch_client!()
        req_path = Utils.build_req_path("/boards/#{board_id}")

        make_struct(client.get(req_path, {}))
      end

      private

      def make_struct(payload)
        id, name = payload.fetch_values("id", "name")
        shortcut = Entities.make_shortcut(:board, id)

        Entities::Board.new(id, shortcut, name)
      end
    end
  end
end
