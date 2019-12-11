# frozen_string_literal: true

require_relative './shared_card_functions.rb'

module Tr3llo
  module Command
    module Card
      class ShowCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            SharedFunctions.load_lists(@board_id)

            card = SharedFunctions.load_card(SharedFunctions.select_card)

            Tr3llo::Presenter::Card::ShowPresenter
              .new(interface)
              .print!(card)
          end
        end

        private

        attr_reader :board_id

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
