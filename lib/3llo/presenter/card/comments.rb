# frozen_string_literal: true

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
            "#{decorate_user(comment[:memberCreator])}: #{comment[:data][:text]}"
          )
        end

        def decorate_user(user)
          "@#{user[:username]}".blue
        end
      end
    end
  end
end
