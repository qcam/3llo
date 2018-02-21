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
          if card.has_key?(:labels)
            label_str = card[:labels].map { |label| colorize_label(label) }.join(", ")
          else
            label_str = ''
          end

          if card[:subscribed]
            subscribed_str = "[✓]"
          else
            subscribed_str = "[ ]"
          end

          interface.puts "#{subscribed_str} #{card[:id].labelize}] - #{card[:name]} (#{label_str})"
        end

        def colorize_label(label)
          if label[:color]
            "##{label[:name]}".paint(label[:color])
          else
            "##{label[:name]}"
          end
        end
      end
    end
  end
end
