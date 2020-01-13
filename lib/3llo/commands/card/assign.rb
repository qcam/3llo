module Tr3llo
  module Command
    module Card
      module AssignCommand
        extend self

        def execute(key, board_id)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          card = API::Card.find(card_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            member_ids = select_user(interface, card, board_id)

            assign_card(card_id, member_ids)
            interface.puts("Chosen members have been assigned to the card.")
          end
        end

        private

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid list key") unless card_id
        end

        def assign_card(card_id, member_ids)
          API::Card.assign_members(card_id, member_ids)
        end

        def select_user(interface, card, board_id)
          user_options =
            API::User.find_all_by_board(board_id)
            .map { |user| [user.username, user.id] }
            .to_h()

          member_ids =
            card.members.flat_map do |member|
              index = user_options.find_index { |_username, user_id| user_id == member.id }

              if index then [index + 1] else [] end
            end

          interface.input.multi_select(
            "Choose the users to assign this card to:",
            user_options,
            default: member_ids,
            enum: "."
          )
        end
      end
    end
  end
end
