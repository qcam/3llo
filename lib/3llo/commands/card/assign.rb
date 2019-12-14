# frozen_string_literal: true

module Tr3llo
  module Command
    module Card
      class AssignCommand
        def initialize(card_id, board_id)
          @card_id = card_id
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            SharedFunctions.load_lists(@board_id)
            @card = SharedFunctions.load_card(SharedFunctions.select_card)
            @card_id = @card[:id]

            user_id = prompt_for_user_id!(@board_id)
            assign_card(user_id)
            interface.puts('Card has been assigned.')
          end
        end

        private

        attr_reader :user_id, :card_id

        def assign_card(user_id)
          members = @card[:idMembers] << user_id
          API::Card.assign_members(card_id, members)
        end

        def prompt_for_user_id!(board_id)
          board_id = $container.resolve(:board)[:id]
          users = Tr3llo::API::User.find_all_by_board(board_id)

          @user_id =
            Tr3llo::Presenter::Card::AssignPresenter
            .new(interface)
            .prompt_for_user_id(users)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
