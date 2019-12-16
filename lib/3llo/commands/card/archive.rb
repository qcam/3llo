# frozen_string_literal: true
require_relative '../shared_functions.rb'

module Tr3llo
  module Command
    module Card
      class ArchiveCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            SharedFunctions.load_lists(@board_id)
            @card = SharedFunctions.load_card(SharedFunctions.select_card)
            @card_id = @card[:id]

            archive_card
            interface.puts("The card #{@card[:name].labelize} has been archived.")
          end
        end

        private

        def archive_card
          card = API::Card.find(@card_id)
          API::Card.archive(@card_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
