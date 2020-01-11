module Tr3llo
  module Command
    module Card
      module ShowCommand
        extend self

        def execute(key)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          card = get_card(card_id)
          checklists = get_checklist(card_id)

          Tr3llo::Presenter::Card::ShowPresenter
            .new(interface)
            .print!(card, checklists)
        end

        private

        def get_card(card_id)
          API::Card.find(card_id)
        end

        def get_checklist(card_id)
          API::Checklist.list_by_card_id(card_id)
        end

        def interface
          Application.fetch_interface!()
        end

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid list key") unless card_id
        end
      end
    end
  end
end
