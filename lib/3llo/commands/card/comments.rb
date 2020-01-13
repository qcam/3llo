module Tr3llo
  module Command
    module Card
      module CommentsCommand
        extend self

        def execute(key)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          comments = API::Card.list_comments(card_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            interface.puts(Presenter::Card::CommentsPresenter.render(comments))
          end
        end

        private

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid card key") unless card_id
        end
      end
    end
  end
end
