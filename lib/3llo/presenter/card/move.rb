module Tr3llo
  module Presenter
    module Card
      class MovePresenter
        def initialize(interface)
          @interface = interface
        end

        def prompt_for_list_id(lists)
          choices = lists.reduce({}) do |result, list|
            result.merge(list[:name] => list[:id])
          end

          interface.input.select('Choose the list to be moved to', choices)
        end

        private

        attr_reader :interface

        def present_list(list)
          interface.puts "[#{list[:id].labelize}] - #{list[:name]}"
        end
      end
    end
  end
end
