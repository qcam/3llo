module Tr3llo
  module Presenter
    module Card
      class AssignPresenter
        def initialize(interface)
          @interface = interface
        end

        def prompt_for_user_id(users)
          interface.input.select(
            'Choose the user to be assigned',
            users.map { |user| [user[:username], user[:id]] }.to_h
          )
        end

        private

        attr_reader :interface

      end
    end
  end
end

