module Tr3llo
  module Command
    module Card
      class ArchiveCommand
        def initialize(card_id)
          @card_id = card_id
        end

        def execute
          card = archive_card
          interface.print_frame do
            interface.puts("Card #{card[:name].labelize} archived")
          end
        end

        private

        attr_reader :card_id

        def archive_card
          card = API::Card.find(card_id)
          API::Card.archive(card_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end

