require "spec_helper"

describe Tr3llo::Command::List::List, type: :integration do
  include IntegrationSpecHelper

  describe ".execute" do
    before { $application = build_container() }
    after { $application = nil }

    it "lists all lists in the selected board" do
      board_id = "board:1"

      interface = make_interface($application)

      make_client_mock($application) do |client_mock|
        payload = [
          {"id" => "list:1", "name" => "List 1"},
          {"id" => "list:2", "name" => "List 2"}
        ]

        expect(client_mock).to(
          receive(:get)
          .with(
            req_path("/boards/#{board_id}/lists", list: true),
            {}
          )
          .and_return(payload)
        )
      end

      select_board($application, make_board(board_id))

      execute_command("list list")

      list1_key = $application.resolve(:registry).register(:list, "list:1")
      list2_key = $application.resolve(:registry).register(:list, "list:2")

      output_string = interface.output.string

      expect(output_string).to match("List 1")
      expect(output_string).to match("list:1")
      expect(output_string).to match("#" + list1_key)
      expect(output_string).to match("List 2")
      expect(output_string).to match("list:2")
      expect(output_string).to match("#" + list2_key)
    end
  end
end
