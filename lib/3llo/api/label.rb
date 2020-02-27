module Tr3llo
  module API
    module Label
      extend self

      def find_all_by_board(board_id)
        req_path =
          Utils.build_req_path(
            "/boards/#{board_id}/labels"
          )

        client
          .get(req_path, {})
          .reject! { |label| label["name"].empty? }
          .map do |label_payload|
            make_struct(label_payload)
          end
      end

      def find(label_id)
        req_path = Utils.build_req_path("/labels/#{label_id}")
        label_payload = client.get(req_path, {})

        make_struct(label_payload)
      end

      def update(label_id, data)
        req_path = Utils.build_req_path("/labels/#{label_id}")

        client.put(req_path, {}, data)
      end

      private

      def make_struct(payload)
        id, name, color = payload.fetch_values("id", "name", "color")
        shortcut = Entities.make_shortcut(:label, id)

        Entities::Label.new(id, shortcut, name, color)
      end

      def client
        Application.fetch_client!()
      end
    end
  end
end
