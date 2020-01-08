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
            label_str = card.labels.map { |label| colorize_label(label) }.join(", ")
          else
            label_str = ""
          end

          if card.members.any?
            member_str = card.members.map { |member| member.username }.join(", ")
          else
            member_str = ""
          end

          interface.puts(
            "ID: ".labelize + card.id + "\n" +
            "Name: ".labelize + card.name + "\n" +
            "Description: ".labelize + card.description + "\n" +
            # "List: ".labelize + card[:list][:name] + "\n" +
            # "Comments: ".labelize + card[:badges][:comments].to_s + "\n" +
            # "Attachments: ".labelize + card[:badges][:attachments].to_s + "\n" +
            "Link: ".labelize + card.short_url + "\n" +
            "Labes: ".labelize + label_str + "\n" +
            "Members: ".labelize + member_str + "\n"
          )
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
