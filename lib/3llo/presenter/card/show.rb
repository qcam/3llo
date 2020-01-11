module Tr3llo
  module Presenter
    module Card
      class ShowPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(card)
          interface.print_frame { present_card(card) }
        end

        private

        attr_reader :interface

        def present_card(card)
          if card.labels.any?
            label_str = card.labels.map { |label| format_label(label) }.join(", ")
          else
            label_str = ""
          end

          if card.members.any?
            member_str = card.members.map { |member| member.username }.join(", ")
          else
            member_str = ""
          end

          interface.puts(
            Utils.format_highlight("ID: ") + card.id + "\n" +
            Utils.format_highlight("Name: ") + card.name + "\n" +
            Utils.format_highlight("Description: ") + card.description + "\n" +
            Utils.format_highlight("Link: ") + card.short_url + "\n" +
            Utils.format_highlight("Labes: ") + label_str + "\n" +
            Utils.format_highlight("Members: ") + member_str + "\n"
          )
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
