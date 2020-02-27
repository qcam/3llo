module Tr3llo
  module Command
    module Label
      module Add
        extend self

        def execute(board_id)
          interface = Application.fetch_interface!()

          interface.print_frame do
            name = interface.input.ask("Name:", required: true)
            color = interface.input.select("Choose the color:") do |color_option|
              Utils::TRELLO_LABEL_COLOR.each do |label_color, color_key|
                color_option.choice(label_color, color_key)
              end
            end

            API::Label.create(name, Utils::TRELLO_LABEL_COLOR.key(color), board_id)

            interface.puts("Label has been created.")
          end
        end
      end
    end
  end
end
