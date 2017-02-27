module Tr3llo
  module Command
    module Card
      class ShowCommand
        def initialize(card_id)
          @card_id = card_id
        end

        def execute
          Tr3llo::Presenter::Card::ShowPresenter
            .new(interface)
            .print!(load_card)
        end

        private

        attr_reader :card_id

        def load_card
          API::Card.find(card_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
