module Tr3llo
  module API
    module Card
      extend self

      def find_all_by_list(list_id)
        req_path =
          Utils.build_req_path(
            "/lists/#{list_id}/cards",
            {"members" => "true", "member_fields" => "id,username"}
          )

        client
          .get(req_path, {})
          .map do |card_payload|
            make_struct(card_payload)
          end
      end

      def find_all_by_user(board_id, user_id)
        req_path =
          Utils.build_req_path(
            "/boards/#{board_id}/members/#{user_id}/cards",
            {"list" => "true"}
          )

        client
          .get(req_path, {})
          .map do |card_payload|
            make_struct(card_payload)
          end
      end

      def create(name, description, list_id)
        req_path = Utils.build_req_path("/cards", {})
        payload = {
          "name" => name,
          "desc" => description,
          "idList" => list_id
        }

        client.post(req_path, {}, payload)
      end

      def update(card_id, data)
        req_path = Utils.build_req_path("/cards/#{card_id}")

        client.put(req_path, {}, data)
      end

      def find(card_id)
        req_path =
          Utils.build_req_path(
            "/cards/#{card_id}",
            {"list" => "true", "members" => "true"}
          )

        card_payload = client.get(req_path, {})

        make_struct(card_payload)
      end

      # TODO: Use ".update".
      def move_to_list(card_id, list_id)
        req_path = Utils.build_req_path("/cards/#{card_id}/idList")

        client.put(req_path, {}, {"value" => list_id})
      end

      # TODO: Use ".update".
      def assign_members(card_id, members)
        req_path = Utils.build_req_path("/cards/#{card_id}/idMembers")

        client.put(req_path, {}, {"value" => members.join(",")})
      end

      def list_comments(card_id)
        req_path =
          Utils.build_req_path(
            "/cards/#{card_id}/actions",
            {"filter" => "commentCard"}
          )

        client
          .get(req_path, {})
          .map do |comment_payload|
            id, creator_payload, date = comment_payload.fetch_values("id", "memberCreator", "date")
            text = comment_payload.dig("data", "text")

            created_at = DateTime.iso8601(date)

            creator_id, creator_username = creator_payload.fetch_values("id", "username")
            creator = Entities::User.new(creator_id, _creator_shortcut = nil, creator_username)

            Entities::Comment.new(
              id: id,
              creator: creator,
              created_at: created_at,
              text: text
            )
          end
      end

      def comment(card_id, text)
        req_path = Utils.build_req_path("/cards/#{card_id}/actions/comments")
        payload = {"text" => text}

        client.post(req_path, {}, payload)
      end

      # TODO: Use ".update".
      def archive(card_id)
        req_path = Utils.build_req_path("/cards/#{card_id}")
        payload = {"closed" => "true"}

        client.put(req_path, {}, payload)
      end

      def add_labels(card_id, labels)
        req_path = Utils.build_req_path("/cards/#{card_id}/idLabels")

        client.put(req_path, {}, {"value" => labels.join(",")})
      end

      private

      def make_struct(payload)
        id, name, description, short_url = payload.fetch_values("id", "name", "desc", "shortUrl")
        shortcut = Entities.make_shortcut(:card, id)

        members =
          payload
            .fetch("members", [])
            .map do |member_payload|
            user_id, username = member_payload.fetch_values("id", "username")

            Entities::User.new(user_id, _user_shortcut = nil, username)
          end

        labels =
          payload
            .fetch("labels", [])
            .map do |label_payload|
            label_id = label_payload.fetch("id")
            label_name = label_payload.fetch("name")
            label_color = label_payload["color"]

            Entities::Label.new(id: label_id, shortcut: nil, name: label_name, color: label_color)
          end

        card =
          Entities::Card.new(
            id: id,
            shortcut: shortcut,
            name: name,
            description: description,
            short_url: short_url,
            labels: labels,
            members: members
          )

        if list_payload = payload["list"]
          list_id, list_name = list_payload.fetch_values("id", "name")
          card.list = Entities::List.new(list_id, _list_shortcut = nil, list_name)
        end

        card
      end

      def client
        Application.fetch_client!()
      end
    end
  end
end
