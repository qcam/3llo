module Tr3llo
  module Presenter
    module Card
      class CommentsPresenter
        def initialize(interface)
          @interface = interface
        end

        def print!(comments)
          interface.print_frame do
            comments.each do |comment|
              present_comment(comment)
            end
          end
        end

        private

        attr_reader :interface

        def present_comment(comment)
          interface.puts(
            "#{Utils.format_user(comment.creator)}: #{comment.text}"
          )
        end
      end
    end
  end
end
