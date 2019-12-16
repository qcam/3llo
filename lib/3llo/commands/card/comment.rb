# frozen_string_literal: true
require_relative '../shared_functions.rb'

module Tr3llo
  module Command
    module Card
      class CommentCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            SharedFunctions.load_lists(@board_id)
            card = SharedFunctions.load_card(SharedFunctions.select_card)
            @card_id = card[:id]

            text = interface.input.multiline('Comment (press Ctrl+d to finish):').join('')

            interface.puts(
              create_comment!(text) &&
              'Comment created'
            )
          end
        end

        private

        def create_comment!(text)
          API::Card.comment(@card_id, text)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
