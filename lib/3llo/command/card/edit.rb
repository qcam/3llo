module Tr3llo
  module Command
    module Card
      module Edit
        extend self

        def execute(card_key)
          card_id = Entities.parse_id(:card, card_key)
          assert_card_id!(card_id, card_key)

          card = API::Card.find(card_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Name: ", required: true, default: card.name)
            description = interface.input.ask("Description: ", default: card.description)

            API::Card.update(card_id, name: name, description: description)

            interface.puts("Card has been updated.")
          end
        end

        private

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid list key") unless card_id
        end
      end
    end
  end
end
