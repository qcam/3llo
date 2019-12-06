module Tr3llo
  module Command
    module Card
      class ListCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          card = load_card(select_card)

          Tr3llo::Presenter::Card::EditPresenter
            .new(interface)
            .print!(card)

            name = interface.input.ask("New name:")
            description = interface.input.ask("New description:")

            interface.puts(
              update_card!(name, description, @card_id) &&
              "Card updated"
            )

        end

        private

        attr_reader :board_id

        def select_card
          @card_id =  interface.input.select("Card to select", card_choices)
        end

        def card_choices
          API::Card
            .find_all_by_board(board_id)
            .map { |card| [card[:name], card[:id]] }
            .to_h
        end
        
        def load_card(card_id)
          API::Card.find(card_id)
        end

        def update_card!(name, description, card_id)
          API::Card.update(name, description, card_id)
        end

        def load_lists   
          API::List.find_all_by_board(board_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end


# module Tr3llo
#   module Command
#     module Card
#       class EditCommand

#         def initialize(card_id)
#           @card_id = card_id
#         end

#         def execute
#           Tr3llo::Presenter::Card::EditPresenter
#             .new(interface)
#             .print!(load_card)

#             name = interface.input.ask("New name:")
#             description = interface.input.ask("New description:")

#             interface.puts(
#               update_card!(name, description, card_id) &&
#               "Card updated"
#             )

#         end

#         private

#         attr_reader :card_id

#         def load_card
#           API::Card.find(card_id)
#         end

#         def update_card!(name, description, card_id)
#           API::Card.update(name, description, card_id)
#         end

#         def interface
#           $container.resolve(:interface)
#         end
#       end
#     end
#   end
# end
