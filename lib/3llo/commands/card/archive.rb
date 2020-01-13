module Tr3llo
  module Command
    module Card
      module ArchiveCommand
        extend self

        def execute(key)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          interface = Application.fetch_interface!()

          interface.print_frame do
            should_proceed = interface.input.yes?("Are you sure you want to archive this card?")

            if should_proceed
              card = archive_card(card_id)
              interface.puts("Card #{Utils.format_highlight(card.name)} has been archived.")
            end
          end
        end

        private

        def archive_card(card_id)
          card = API::Card.find(card_id)
          API::Card.archive(card_id)
          card
        end

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid card key") unless card_id
        end
      end
    end
  end
end
