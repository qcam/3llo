module Tr3llo
  module Presenter
    module Card
      module CommentsPresenter
        extend self

        def render(comments)
          if comments.any?
            comments
              .map { |comment| render_comment(comment) }
              .join("\n\n")
          else
            "No comments on this card yet. Use #{Utils.format_highlight("card comment")} to write the first comment."
          end
        end

        private

        def render_comment(comment)
          <<~TEMPLATE.strip
          #{Utils.format_bold(Utils.format_user(comment.creator))} on <#{format_date_time(comment.created_at)}> wrote:
          #{comment.text}
          TEMPLATE
        end

        def format_date_time(date_time)
          Utils.format_dim(date_time.strftime("%b %d, %Y %H:%M:%S"))
        end
      end
    end
  end
end
