module Tr3llo
  module Presenter
    module Card
      class MovePresenter
        def initialize(interface)
          @interface = interface
        end

        def prompt_for_list_id(lists)
          interface.puts("List of lists in this board")
          lists.each(&method(:present_list))
          interface.prompt("Select list ID")
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
