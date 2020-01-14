module Tr3llo
  module View
    module List
      module List
        extend self

        def render(lists)
          lists
            .map { |list| render_list(list) }
            .join("\n")
        end

        private

        def render_list(list)
          "#{Utils.format_key_tag(list.id, list.shortcut)} #{list.name}"
        end
      end
    end
  end
end
