require "spec_helper"

describe "label remove <label key>", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "delete a label" do
    board_id = "board:1"
    label_id = "label:1"

    select_board($application, make_board(board_id))

    # Mock HTTP request.
    make_client_mock($application) do |client_mock|
      expect(client_mock).to(
        receive(:delete)
          .with(
            req_path("/labels/#{label_id}"), {}, {}
          )
          .and_return("{}")
      )
    end

    interface = make_interface($application)
    execute_command("label remove " + label_id)

    output_string = interface.output.string

    expect(output_string).to match("Label has been deleted.")
  end
end
