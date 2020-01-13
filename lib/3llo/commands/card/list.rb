module Tr3llo
  module Command
    module Card
      module ListCommand
        extend self

        def execute(board_id)
          lists_cards =
            get_lists(board_id)
              .map do |list|
                Thread.new { [list, get_cards(list.id)] }
              end
              .map { |thread| thread.join.value }

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts(
              lists_cards.map do |list, cards|
                Presenter::Card::ListPresenter.render(list, cards)
              end.join("\n\n\n")
            )
          end
        end

        private

        attr_reader :board_id

        def get_lists(board_id)
          API::List.find_all_by_board(board_id)
        end

        def get_cards(list_id)
          API::Card.find_all_by_list(list_id)
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
