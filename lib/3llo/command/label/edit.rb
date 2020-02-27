module Tr3llo
  module Command
    module Label
      module Edit
        extend self

        def execute(label_key)
          label_id = Entities.parse_id(:label, label_key)
          assert_label_id!(label_id, label_key)

          label = API::Label.find(label_id)

          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Name:", required: true, value: label.name)
            color = interface.input.select("Choose the color:") do |color_option|
              color_option.default Utils::TRELLO_LABEL_COLOR[label.color]

              Utils::TRELLO_LABEL_COLOR.each do |label_color, color_key|
                color_option.choice(label_color, color_key)
              end
            end

            API::Label.update(label_id, {"name" => name, "color" => Utils::TRELLO_LABEL_COLOR.key(color)})

            interface.puts("Label has been updated.")
          end
        end

        private

        def assert_label_id!(label_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid label key") unless label_id
        end
      end
    end
  end
end
