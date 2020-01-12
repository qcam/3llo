module Tr3llo
  module Command
    module Card
      module InvalidCommand
        extend self

        def execute(message)
          interface.print_frame do
            interface.print_error(message)
            interface.puts(menu_text)
          end
        end

        private

        def menu_text
          %q{
    # Available `card` commands:

    card list               - Show list of cards grouped by list
    card list mine          - Show list of my cards
    card add                - Create a card
    card show <key>         - Show card information
    card move <key>         - Move card to a list
    card self-assign <key>  - Self-assign a card
    card assign <key>       - Assign a user to a card
    card comments <key>     - Load recent comments of a card
    card comment <key>      - Add a comment to a card
    card archive <key>      - Archive a card

    # Available checklists related commands:

    card add-checklist <card_key>             - Create a checklist on a card
    card edit-checklist <checklist_key>       - Edit a checklist
    card remove-checklist <checklist_key>     - Remove a checklist
    card add-item <checklist_key>             - Add an item to a checklist
    card edit-item <card_key> <item_key>      - Edit an item
    card check-item <card_key> <item_key>     - Mark an item as complete
    card uncheck-item <card_key> <item_key>   - Mark an item as incomplete
    card remove-item <card_key> <item_key>    - Remove an item
          }
        end

        def interface
          Application.fetch_interface!()
        end
      end
    end
  end
end
