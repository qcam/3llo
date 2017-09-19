module Tr3llo
  module Command
    module Card
      class CommentCommand
        def initialize(card_id)
          @card_id = card_id
        end

        def execute
          interface.print_frame do
            text = interface.input.ask("Comment:")

            interface.puts(
              create_comment!(text) &&
              "Comment created"
            )
          end
        end

        private

        attr_reader :card_id

        def create_comment!(text)
          API::Card.comment(@card_id, text)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
