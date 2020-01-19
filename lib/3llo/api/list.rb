module Tr3llo
  module API
    module List
      extend self

      def find_all_by_board(board_id)
        req_path =
          Utils.build_req_path(
            "/boards/#{board_id}/lists",
            {"list" => "true"}
          )

        client
          .get(req_path, {})
          .map do |list_payload|
            make_struct(list_payload)
          end
      end

      def archive_cards(list_id)
        req_path = Utils.build_req_path("/lists/#{list_id}/archiveAllCards")

        client.post(req_path, {}, {})
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
    end
  end
end
