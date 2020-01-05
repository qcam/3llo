module Tr3llo
  module Command
    module Card
      module ArchiveCommand
        extend self

        def execute(key)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          interface.print_frame do
            card = archive_card(card_id)
            interface.puts("Card #{card[:name].labelize} has been archived.")
          end
        end

        private

        def archive_card(card_id)
          card = API::Card.find(card_id)
          API::Card.archive(card_id)
          card
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
