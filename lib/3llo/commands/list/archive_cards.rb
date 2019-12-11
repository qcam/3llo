# frozen_string_literal: true

module Tr3llo
  module Command
    module List
      class ArchiveCardsCommand
        def initialize(list_id)
          @list_id = list_id
        end

        def execute
          interface.print_frame do
            approved = prompt_for_approvement!
            if approved
              archive_cards
              interface.puts('Cards have been archived.')
            end
          end
        end

        private

        attr_reader :list_id

        def prompt_for_approvement!
          Tr3llo::Presenter::ConfirmationPresenter
            .new(interface)
            .prompt_for_confirmation('Are you sure you want to archive all cards?')
        end

        def archive_cards
          API::List.archive_cards(list_id)
        end

        def interface
          $container.resolve(:interface)
        end
      end
    end
  end
end
