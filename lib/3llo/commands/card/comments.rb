# frozen_string_literal: true
require_relative './shared_card_functions.rb'

module Tr3llo
  module Command
    module Card
      class CommentsCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          SharedFunctions.load_lists(@board_id)
          card = SharedFunctions.load_card(SharedFunctions.select_card)
          @card_id = card[:id]

          Tr3llo::Presenter::Card::CommentsPresenter
            .new(interface)
            .print!(load_comments)
        end

        private

        def load_comments
          API::Card.find_comments(@card_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
