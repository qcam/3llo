# frozen_string_literal: true

require_relative './shared_card_functions.rb'

module Tr3llo
  module Command
    module Card
      class EditCommand
        def initialize(board_id)
          @board_id = board_id
        end

        def execute
          interface.print_frame do
            SharedFunctions.load_lists(@board_id)
            card = SharedFunctions.load_card(SharedFunctions.select_card)

            Tr3llo::Presenter::Card::EditPresenter
              .new(interface)
              .print!(card)

            @card_id = card[:id]

            name = interface.input.ask('Change the name:')
            description = interface.input.ask('Change the description:')

            interface.puts(
              update_card!(
                name,
                description,
                @card_id
              ) &&
              "The card #{card[:name].labelize} has been editted."
            )
          end
        end

        private

        attr_reader :board_id

        def update_card!(name, description, card_id)
          API::Card.update(name, description, card_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
