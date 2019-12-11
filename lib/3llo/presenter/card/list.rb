# frozen_string_literal: true

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
            interface.puts('=' * list[:name].length)
            cards.each { |card| present_card(card) }
          end
        end

        private

        attr_reader :interface

        def present_card(card)
          label_str = if card.key?(:labels)
                        card[:labels].map { |label| colorize_label(label) }.join(', ')
                      else
                        ''
                      end

          if card.key?(:members)
            members_str = card[:members].map { |member| "@#{member[:username]}".blue }.join(', ')
          else
            members_str = ''
          end

          subscribed_str = if card[:subscribed]
                             '[✓]'
                           else
                             '[ ]'
                           end

          interface.puts "[#{subscribed_str} #{card[:id].labelize}] - #{card[:name]} (#{label_str}) [#{members_str}]"
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
