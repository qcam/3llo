module Tr3llo
  module Presenter
    module Card
      class MovePresenter
        def initialize(interface)
          @interface = interface
        end

        def prompt_for_list_id(lists)
          interface.input.select(
            'Choose the list to be moved to',
            lists.map { |list| [list[:name], list[:id]] }.to_h
          )
        end

        private

        attr_reader :interface
      end
    end
  end
end
