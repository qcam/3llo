module Tr3llo
  module View
    module Card
      module List
        extend self

        def render(list, cards)
          <<~TEMPLATE.strip
          #{Utils.paint("##{list.name}", "purple")}
          #{"=" * (list.name.length + 1)}
          #{render_cards(cards)}
          TEMPLATE
        end

        private

        def render_cards(cards)
          if cards.any?
            cards
              .map do |card|
                key_tag = Utils.format_key_tag(card.id, card.shortcut)

                "#{key_tag} #{card.name}#{render_labels(card.labels)}#{render_members(card.members)}"
              end
              .join("\n")
          else
            "(No cards)"
          end
        end

        def render_labels(labels)
          if labels.any?
            " [" + labels.map { |label| format_label(label) }.join(", ") + "]"
          else
            ""
          end
        end

        def render_members(members)
          if members.any?
            " [" + members.map { |member| Utils.format_user(member) }.join(", ") + "]"
          else
            ""
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
