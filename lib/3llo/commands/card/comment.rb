module Tr3llo
  module Command
    module Card
      module CommentCommand
        extend self

        def execute(key)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          interface.print_frame do
            text = interface.input.multiline("Comment (press Ctrl+d to finish):").join("")

            interface.puts(
              create_comment!(card_id, text) &&
              "Comment created"
            )
          end
        end

        private

        def create_comment!(card_id, text)
          API::Card.comment(card_id, text)
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
