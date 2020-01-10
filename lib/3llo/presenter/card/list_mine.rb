module Tr3llo
  module Presenter
    module Card
      class ListMinePresenter
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
          interface.puts "#{Utils.format_key_tag(card.id, card.shortcut)} (#{Utils.paint(card.list.name, "purple")}) #{card.name}"
        end
      end
    end
  end
end
