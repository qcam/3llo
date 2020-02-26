module Tr3llo
  module View
    module Label
      module List
        extend self

        def render(labels)
          labels
            .map { |label| render_label(label) }
            .join("\n")
        end

        private

        def render_label(label)
          "#{Utils.format_key_tag(label.id, label.shortcut)} #{Utils.paint("#" + label.name, label.color)}"
        end
      end
    end
  end
end
