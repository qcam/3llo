# frozen_string_literal: true

module Tr3llo
  module Presenter
    module Card
      class EditPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(card)
          interface.print_frame { present_card(card) }
        end

        private

        attr_reader :interface

        def present_card(card)
          label_str = if card.key?(:labels)
                        card[:labels].map { |label| colorize_label(label) }.join(', ')
                      else
                        ''
                      end

          member_str = if card.key?(:members)
                         card[:members].map { |member| member[:username] }.join(', ')
                       else
                         ''
                       end

          interface.puts(
            'ID-------->: '.labelize + card[:id] + "\n" +
            'Name: '.labelize + card[:name] + " (#{label_str})" "\n" +
            'Description: '.labelize + card[:desc] + "\n" +
            'List: '.labelize + card[:list][:name] + "\n" +
            'Subscribed: '.labelize + (card[:badges][:subscribed] ? 'Yes' : 'No') + "\n" +
            'Comments: '.labelize + card[:badges][:comments].to_s + "\n" +
            'Attachments: '.labelize + card[:badges][:attachments].to_s + "\n" +
            'Link: '.labelize + card[:shortUrl] + "\n" +
            'Labes: '.labelize + label_str + "\n" +
            'Members: '.labelize + member_str + "\n"
          )
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
