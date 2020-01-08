module Tr3llo
  module Command
    module Card
      module CommentsCommand
        extend self

        def execute(key)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          comments = list_comments(card_id)

          Tr3llo::Presenter::Card::CommentsPresenter
            .new(interface)
            .print!(comments)
        end

        private

        def list_comments(card_id)
          API::Card.list_comments(card_id)
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
