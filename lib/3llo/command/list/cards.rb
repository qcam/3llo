module Tr3llo
  module Command
    module List
      module Cards
        extend self

        def execute(list_key)
          list_id = Entities.parse_id(:list, list_key)
          assert_list_id!(list_id, list_key)

          cards = list_cards(list_id)

          interface.print_frame do
            interface.puts(View::List::Cards.render(cards))
          end
        end

        private

        def list_cards(list_id)
          API::Card.find_all_by_list(list_id)
        end

        def interface
          Application.fetch_interface!()
        end

        def assert_list_id!(list_id, list_key)
          raise InvalidArgumentError.new("#{list_key.inspect} is not a valid list key") unless list_id
        end
      end
    end
  end
end
