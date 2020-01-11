module Tr3llo
  module Presenter
    module Card
      class ListPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(list, cards)
          interface.print_frame do
            interface.puts(Utils.paint("##{list[:name]}", "purple"))
            interface.puts("=" * list[:name].length)
            cards.each { |card| present_card(card) }
          end
        end

        private

        attr_reader :interface

        def present_card(card)
          key_tag = Utils.format_key_tag(card.id, card.shortcut)

          if card.labels.any?
            label_tag = " [" + card.labels.map { |label| format_label(label) }.join(", ") + "]"
          else
            label_tag = ""
          end

          if card.members.any?
            member_tag = card.members.map { |member| Utils.format_user(member) }.join(", ")
            member_tag = " [" + member_tag + "]"
          else
            member_tag = ""
          end

          interface.puts "#{key_tag} #{card.name}#{label_tag}#{member_tag}"
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
