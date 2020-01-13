module Tr3llo
  module Presenter
    module List
      module CardsPresenter
        extend self

        def render(cards)
          cards.map { |card| render_card(card) }.join("\n")
        end

        private

        def render_card(card)
          label_tag =
            if card.labels.any?
              " (" + card[:labels].map { |label| format_label(label) }.join(", ") + ")"
            else
              ""
            end

          "#{Utils.format_key_tag(card.id, card.shortcut)} #{card.name}#{label_tag}"
        end

        def format_label(label)
          if label.color
            Utils.paint("##{label.name}", label.color)
          else
            "##{label.name}"
          end
        end
      end
    end
  end
end
