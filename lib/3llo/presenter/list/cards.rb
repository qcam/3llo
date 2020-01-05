module Tr3llo
  module Presenter
    module List
      class CardsPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(cards)
          interface.print_frame do
            cards.each { |card| present_card(card) }
          end
        end

        private

        attr_reader :interface

        def present_card(card)
          if card.labels.any?
            label_tag = " (" + card[:labels].map { |label| colorize_label(label) }.join(", ") + ")"
          else
            label_tag = ""
          end

          interface.puts "#{Utils.format_key_tag(card.id, card.shortcut)} #{card.name}#{label_tag}"
        end

        def colorize_label(label)
          if label.color
            "##{label.name}".paint(label.color)
          else
            "##{label.name}"
          end
        end
      end
    end
  end
end
