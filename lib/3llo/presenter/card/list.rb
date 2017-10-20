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
          if card.has_key?(:labels)
            label_str = card[:labels].map { |label| colorize_label(label) }.join(", ")
          else
            label_str = ''
          end

          if card.has_key?(:members)
            members_str = card[:members].map { |member| "@#{member[:username]}".blue }.join(", ")
          else
            members_str = ''
          end

          if card[:subscribed]
            subscribed_str = "[✓]"
          else
            subscribed_str = "[ ]"
          end

          interface.puts "[#{subscribed_str} #{card[:id].labelize}] - #{card[:name]} (#{label_str}) [#{members_str}]"
        end

        def colorize_label(label)
          "##{label[:name]}".paint(label[:color])
        end
      end
    end
  end
end
