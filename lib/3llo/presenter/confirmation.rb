module Tr3llo
  module Presenter
    class ConfirmationPresenter
      def initialize(interface)
        @interface = interface
      end

      def prompt_for_confirmation(message)
        answer = interface.input.select(message, ['No', 'Yes'])
        answer == 'Yes'
      end

      private

      attr_reader :interface
    end
  end
end
