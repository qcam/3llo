module Tr3llo
  module Command
    module Card
      class SelfAssignCommand
        def initialize(card_id, user_id)
          @card_id = card_id
          @user_id = user_id
        end

        def execute
          card = assign_card
          interface.print_frame do
            interface.puts("Card #{card[:name].labelize} self-assigned")
          end
        end

        private

        attr_reader :user_id, :card_id

        def assign_card
          card = API::Card.find(card_id)
          members = card[:idMembers] << user_id
          API::Card.assign_members(card_id, members)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
