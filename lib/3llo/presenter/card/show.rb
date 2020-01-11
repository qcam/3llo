module Tr3llo
  module Presenter
    module Card
      class ShowPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(card, checklists)
          interface.print_frame do
            present_card(card)
            present_checklists(checklists)
          end
        end

        private

        attr_reader :interface

        def present_card(card)
          if card.labels.any?
            label_tag = " [" + card.labels.map { |label| format_label(label) }.join(", ") + "]"
          else
            label_tag = ""
          end

          if card.members.any?
            member_tag = " (" + card.members.map { |member| Utils.format_user(member) }.join(", ") + ")"
          else
            member_tag = ""
          end

          if card.description && card.description != ""
            description_string = "\n" + card.description
          else
            description_string = ""
          end

          key_tag = Utils.format_key_tag(card.id, card.shortcut)

          interface.puts(
            Utils.format_bold(card.name) + member_tag + label_tag + "\n" +
            key_tag + "\n" +
            "Link: " + Utils.paint(card.short_url, "blue") + "\n" +
            description_string
          )
        end

        def present_checklists(checklists)
          checklists.each do |checklist|
            interface.puts("\n")
            interface.puts(Utils.format_highlight(Utils.format_bold(checklist.name)))
            interface.puts("=" * checklist.name.length)

            checklist.items.each do |item|
              formatted_state =
                case item.state
                when "complete" then "[" + Utils.format_bold("x") + "]"
                when "incomplete" then "[ ]"
                end

              interface.puts("#{formatted_state} #{item.name}")
            end
          end
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
