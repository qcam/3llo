require "spec_helper"

describe "label list", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "requires board to be selected" do
    interface = make_interface($application)

    execute_command("label list")

    output_string = interface.output.string
    expect(output_string).to match("Board has not been selected.")
  end

  it "lists all labels by board_id" do
    board_id = "board:1"
    select_board($application, make_board(board_id))

    # Mock HTTP request.
    make_client_mock($application) do |client_mock|
      payload = [
        {"id" => "label:1", "name" => "Label 1", "color" => "red"},
        {"id" => "label:2", "name" => "Label 2", "color" => "green"}
      ]

      expect(client_mock).to(
        receive(:get)
        .with(
          Tr3llo::Utils.build_req_path("/boards/#{board_id}/labels"), {}
        )
        .and_return(payload)
      )
    end

    interface = make_interface($application)

    execute_command("label list")

    label1_shortcut = $application.resolve(:registry).register(:label, "label:1")
    label2_shortcut = $application.resolve(:registry).register(:label, "label:2")

    output_string = interface.output.string

    expect(output_string).to match("Label 1")
    expect(output_string).to match("Label 2")
    expect(output_string).to match("label:1")
    expect(output_string).to match("label:2")
    expect(output_string).to match("#" + label1_shortcut)
    expect(output_string).to match("#" + label2_shortcut)
  end
end
