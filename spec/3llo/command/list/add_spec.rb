require "spec_helper"

describe "list add", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "creates a new list" do
    board_id = "board:1"

    select_board($application, make_board(board_id))

    make_client_mock($application) do |client_mock|
      expect(client_mock).to(
        receive(:post)
          .with(
            req_path("/lists"),
            _headers = {},
            _payload = {
              "name" => "List 1",
              "idBoard" => board_id
            }
          )
          .and_return({})
      )
    end

    interface = make_interface($application) do |input, _output|
      expect(input).to receive(:ask).with("Name:", required: true).and_return("List 1")
    end

    execute_command("list add")

    output_string = interface.output.string

    expect(output_string).to match("List has been created.")
  end
end
