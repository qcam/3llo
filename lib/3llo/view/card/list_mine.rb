module Tr3llo
  module View
    module Card
      module ListMine
        extend self

        def render(cards)
          if cards.any?
            cards
              .map { |card| render_card(card) }
              .join("\n")
          else
            "You are currently assigned to no cards"
          end
        end

        private

        def render_card(card)
          "#{Utils.format_key_tag(card.id, card.shortcut)} (#{Utils.paint(card.list.name, "purple")}) #{card.name}"
        end
      end
    end
  end
end
