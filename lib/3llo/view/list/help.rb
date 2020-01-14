module Tr3llo
  module View
    module List
      module Help
        extend self

        def render()
          <<~TEMPLATE.strip
          #{Utils.format_bold("# Available list commands:")}

          list list                 - Show all lists
          list cards <key>          - Show all cards in list
          list archive-cards <key>  - Archive all cards in list
          TEMPLATE
        end
      end
    end
  end
end
