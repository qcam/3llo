# frozen_string_literal: true

module Tr3llo
  module Command
    module List
      class CardsCommand
        def initialize(list_id)
          @list_id = list_id
        end

        def execute
          Tr3llo::Presenter::List::CardsPresenter
            .new(interface)
            .print!(list_cards)
        end

        private

        attr_reader :list_id

        def list_cards
          API::Card.find_all_by_list(list_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
