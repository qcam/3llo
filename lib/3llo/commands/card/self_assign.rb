module Tr3llo
  module Command
    module Card
      module SelfAssignCommand
        extend self

        def execute(key, user_id)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          card = assign_card(card_id, user_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts("Card has been assigned to yourself")
          end
        end

        private

        def assign_card(card_id, user_id)
          card = API::Card.find(card_id)
          members = card.members.map { |member| member.id } + [user_id]

          API::Card.assign_members(card_id, members)
        end

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid card key") unless card_id
        end
      end
    end
  end
end
