module Tr3llo
  module Command
    module List
      module ArchiveCards
        extend self

        def execute(key)
          list_id = Entities.parse_id(:list, key)
          interface = Application.fetch_interface!()

          interface.print_frame do
            is_approved = interface.input.yes?("Are you sure you want to archive all cards?")

            if is_approved
              archive_cards(list_id)
              interface.puts("All cards on the list have been archived.")
            end
          end
        end

        private

        def prompt_for_approvement!
          Tr3llo::Presenter::ConfirmationPresenter
            .new(interface)
            .prompt_for_confirmation('')
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
