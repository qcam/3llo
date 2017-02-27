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
          if card.has_key?(:labels)
            label_str = card[:labels].map { |label| colorize_label(label) }.join(", ")
          else
            label_str = ''
          end

          interface.puts(
            "ID: ".labelize + card[:id] + "\n" +
            "Name: ".labelize + card[:name] + " (#{label_str})" "\n" +
            "Description: ".labelize + card[:desc] + "\n" +
            "List: ".labelize + card[:list][:name] + "\n" +
            "Link: ".labelize + card[:shortUrl] + "\n"
          )
        end

        def colorize_label(label)
          "##{label[:name]}".paint(label[:color])
        end
      end
    end
  end
end
