module Tr3llo
  module View
    module Label
      module Help
        extend self

        def render()
          <<~TEMPLATE.strip
          #{Utils.format_bold("# Available label commands:")}

          label list                - Show all labels
          label add                 - Create a label
          label edit <key>          - Edit a label
          list remove <key>         - Remove a label
          TEMPLATE
        end
      end
    end
  end
end
