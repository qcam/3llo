module Tr3llo
  module Presenter
    module List
      module ListPresenter
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
