# frozen_string_literal: true

module Tr3llo
  module Command
    module Card
      class CommentsCommand
        def initialize(card_id)
          @card_id = card_id
        end

        def execute
          Tr3llo::Presenter::Card::CommentsPresenter
            .new(interface)
            .print!(load_comments)
        end

        private

        attr_reader :card_id

        def load_comments
          API::Card.find_comments(card_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
