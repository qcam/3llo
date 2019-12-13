# frozen_string_literal: true
require_relative './shared_card_functions.rb'

module Tr3llo
  module Command
    module Card
      class SelfAssignCommand
        def initialize(user_id, board_id)
          @user_id = user_id
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            SharedFunctions.load_lists(@board_id)
            card = SharedFunctions.load_card(SharedFunctions.select_card)
            @card_id = card[:id]
            assign_card
            interface.puts("The card #{card[:name].labelize} is now assigned to you.")

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
