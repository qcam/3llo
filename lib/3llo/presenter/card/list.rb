module Tr3llo
  module Presenter
    module Card
      class ListPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(list, cards)
          interface.print_frame do
            interface.puts("##{list[:name]}".purple)
            interface.puts("=" * list[:name].length)
            cards.each { |card| present_card(card) }
          end
        end

        private

        attr_reader :interface

        def present_card(card)
          interface.puts "[#{card[:id].labelize}] - #{card[:name]}"
        end
      end
    end
  end
end
