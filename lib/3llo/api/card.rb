module Tr3llo
  module API
    module Card
      extend self

      def find_all_by_list(list_id)
        JSON.parse(
          client.get(
            "/lists/#{list_id}/cards",
            key: api_key,
            token: api_token,
            members: 'true',
            member_fields: "id,username"
          )
        ).map do |card_payload|
          make_struct(card_payload)
        end
      end

      def find_all_by_user(board_id, user_id)
        JSON.parse(
          client.get(
            "/boards/#{board_id}/members/#{user_id}/cards",
            list: true,
            key: api_key,
            token: api_token
          )
        ).map do |card_payload|
          make_struct(card_payload)
        end
      end

      def create(name, description, list_id)
        JSON.parse(
          client.post(
            "/cards",
            key: api_key,
            token: api_token,
            name: name,
            desc: description,
            idList: list_id
          )
        )
      end

      def find(card_id)
        card_payload =
          JSON.parse(
            client.get(
              "/cards/#{card_id}",
              list: true,
              members: true,
              key: api_key,
              token: api_token
            )
          )

        make_struct(card_payload)
      end

      def move_to_list(card_id, list_id)
        url = "/cards/#{card_id}/idList"
        JSON.parse(
          client.put(
            url,
            key: api_key,
            token: api_token,
            value: list_id
          )
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
          )
        )
      end

      def list_comments(card_id)
        url = "/cards/#{card_id}/actions"

        JSON.parse(
          client.get(
            url,
            key: api_key,
            token: api_token,
            filter: "commentCard",
          )
        ).map do |comment_payload|
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
        url = "/cards/#{card_id}/actions/comments"
        JSON.parse(
          client.post(
            url,
            key: api_key,
            token: api_token,
            text: text
          )
        )
      end

      def archive(card_id)
        url = "/cards/#{card_id}?closed=true"
        JSON.parse(
          client.put(
            url,
            key: api_key,
            token: api_token
          )
        )
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
            label_name = label_payload.fetch("name")
            label_color = label_payload["color"]

            Entities::Label.new(label_name, label_color)
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
