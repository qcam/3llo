module Tr3llo
  module Command
    module Label
      module Remove
        extend self

        def execute(label_key)
          label_id = Entities.parse_id(:label, label_key)
          assert_label_id!(label_id, label_key)

          interface = Application.fetch_interface!()

          interface.print_frame do
            API::Label.delete(label_id)

            interface.puts("Label has been deleted.")
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
