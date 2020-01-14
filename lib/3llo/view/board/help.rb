module Tr3llo
  module View
    module Board
      module Help
        extend self

        def render()
          <<~TEMPLATE.strip
          #{Utils.format_bold("# Available board commands:")}

          board list                - Show list of boards
          board select <board_key>  - Select board
          TEMPLATE
        end
      end
    end
  end
end
