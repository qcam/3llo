module Tr3llo
  module Presenter
    module Card
      module CommentsPresenter
        extend self

        def render(comments)
          if comments.any?
            comments
              .map { |comment| render_comment(comment) }
              .join("\n")
          else
            "No comments on this card yet. Use #{Utils.format_highlight("card comment")} to write the first comment."
          end
        end

        private

        def render_comment(comment)
          "#{Utils.format_user(comment.creator)}: #{comment.text}"
        end
      end
    end
  end
end
