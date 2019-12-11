# frozen_string_literal: true

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

        def present_list(list)
          interface.puts "[#{list[:id].labelize}] - #{list[:name]}"
        end
      end
    end
  end
end
