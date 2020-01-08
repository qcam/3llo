module Tr3llo
  module Command
    module List
      module ArchiveCardsCommand
        extend self

        def execute(key)
          list_id = Entities.parse_id(:list, key)

          interface.print_frame do
            approved = prompt_for_approvement!

            if approved
              archive_cards(list_id)
              interface.puts("Cards have been archived.")
            end
          end
        end

        private

        def prompt_for_approvement!
          Tr3llo::Presenter::ConfirmationPresenter
            .new(interface)
            .prompt_for_confirmation('Are you sure you want to archive all cards?')
        end

        def archive_cards(list_id)
          API::List.archive_cards(list_id)
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
