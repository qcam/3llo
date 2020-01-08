module Tr3llo
  module Presenter
    module List
      class ListPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(lists)
          interface.print_frame do
            lists.each { |list| present_list(list) }
          end
        end

        private

        attr_reader :interface

        def present_list(list)
          interface.puts(
            "#{Utils.format_key_tag(list.id, list.shortcut)} #{list.name}"
          )
        end
      end
    end
  end
end
