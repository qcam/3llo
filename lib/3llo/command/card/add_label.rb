module Tr3llo
  module Command
    module Card
      module AddLabel
        extend self

        def execute(key, board_id)
          card_id = Entities.parse_id(:card, key)
          assert_card_id!(card_id, key)

          card = API::Card.find(card_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            label_ids = select_labels(interface, card, board_id)

            add_labels(card_id, label_ids)
            interface.puts("Chosen labels have been added to the card.")
          end
        end

        private

        def assert_card_id!(card_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid card key") unless card_id
        end

        def add_labels(card_id, label_ids)
          API::Card.add_labels(card_id, label_ids)
        end

        def select_labels(interface, card, board_id)
          label_options =
            API::Label.find_all_by_board(board_id)
              .map { |label| [label.name, label.id] }
              .to_h()

          preselected_label_ids =
            card.labels.flat_map do |label|
              index = label_options.find_index { |_label_name, label_id| label_id == label.id }

              index ? [index + 1] : []
            end

          interface.input.multi_select(
            "Choose the labels to add to this card:",
            label_options,
            default: preselected_label_ids,
            enum: "."
          )
        end
      end
    end
  end
end
