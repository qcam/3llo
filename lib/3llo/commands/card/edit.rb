module Tr3llo
  module Command
    module Card
      class EditCommand
        def initialize(card_id)
          @card_id = card_id
        end

        def execute
          Tr3llo::Presenter::Card::EditPresenter
            .new(interface)
            .print!(load_card)

            card = API::Card.find(card_id)

            name = interface.input.ask("New name for: " + "'#{card[:name]}' ".yellow + "(leave blank if no changes are desired):")
            description = interface.input.ask("New description for: " +  "'#{card[:desc]}' ".yellow + "(leave blank if no changes are desired):")

            interface.puts(
              update_card!(name, description, card_id) &&
              "Card updated"
            )

        end

        private

        attr_reader :card_id

        def load_card
          API::Card.find(card_id)
        end

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
