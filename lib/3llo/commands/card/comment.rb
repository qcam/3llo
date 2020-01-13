module Tr3llo
  module Command
    module Card
      module CommentCommand
        extend self

        def execute(key)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          interface = Application.fetch_interface!()

          interface.print_frame do
            text = interface.input.multiline("Comment:").join("")

            API::Card.comment(card_id, text)

            interface.puts("Comment has been posted")
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
