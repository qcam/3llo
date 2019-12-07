module Tr3llo
  module Command
    module Card
      class ShowCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          card = load_card(select_card)

          Tr3llo::Presenter::Card::ShowPresenter
            .new(interface)
            .print!(card)
        end

        private

        attr_reader :board_id

        def select_card
          puts '------------------'
          @card_id = interface.input.select(
            'Select the card you want to see',
            card_choices
          )
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

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
