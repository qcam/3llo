module Tr3llo
  module View
    module Card
      module Show
        extend self

        def render(card, checklists)
          <<~TEMPLATE.strip
          #{Utils.format_bold(card.name)}#{render_members(card.members)}#{render_labels(card.labels)}
          #{Utils.format_key_tag(card.id, card.shortcut)}
          Link: #{Utils.paint(card.short_url, "blue")}
          #{render_description(card.description)}

          #{render_checklists(checklists)}
          TEMPLATE
        end

        private

        def render_description(description)
          if description && description != ""
            "\n" + description
          else
            ""
          end
        end

        def render_members(members)
          if members.any?
            " (" + members.map { |member| Utils.format_user(member) }.join(", ") + ")"
          else
            ""
          end
        end

        def render_labels(labels)
          if labels.any?
            " [" + labels.map { |label| format_label(label) }.join(", ") + "]"
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

        def render_checklists(checklists)
          checklists.map do |checklist|
            formatted_key_tag = Utils.format_key_tag(checklist.id, checklist.shortcut)
            formatted_name = Utils.format_highlight(Utils.format_bold(checklist.name))

            rendered_items =
              checklist.items.map do |item|
                formatted_state =
                  case item.state
                  when "complete" then "[" + Utils.format_bold("x") + "]"
                  when "incomplete" then "[ ]"
                  end

                item_key_tag = Utils.format_key_tag(item.id, item.shortcut)
                "#{formatted_state} #{item.name} #{item_key_tag}"
              end.join("\n")

            <<~TEMPLATE.strip
            #{formatted_name} #{formatted_key_tag}
            #{rendered_items}
            TEMPLATE
          end.join("\n\n")
        end
      end
    end
  end
end
