module Tr3llo
  module Command
    module Card
      module AssignCommand
        extend self

        def execute(key, board_id)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          interface.print_frame do
            user_id = prompt_for_user_id!(board_id)

            assign_card(card_id, user_id)
            interface.puts("Card has been assigned")
          end
        end

        private

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid list key") unless card_id
        end

        def assign_card(card_id, user_id)
          card = API::Card.find(card_id)
          members = card.members.map { |member| member.id } + [user_id]
          API::Card.assign_members(card_id, members)
        end

        def prompt_for_user_id!(board_id)
          users = Tr3llo::API::User.find_all_by_board(board_id)

          Tr3llo::Presenter::Card::AssignPresenter
            .new(interface)
            .prompt_for_user_id(users)
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
