require "spec_helper"

describe "label edit <label key>", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "update a label" do
    board_id = "board:1"
    label_id = "label:1"

    select_board($application, make_board(board_id))

    interface = make_interface($application) do |input, _output|
      expect(input).to receive(:ask).with("Name:", required: true, value: "Label 1").and_return("Label 2")
      expect(input).to(
        receive(:select)
          .with(
            "Choose the color:",
            Tr3llo::Utils::TRELLO_LABEL_COLOR,
            {default: Tr3llo::Utils::TRELLO_LABEL_COLOR.index("green")}
          )
          .and_return("red")
      )
    end

    # Mock HTTP request.
    make_client_mock($application) do |client_mock|
      label_payload = {
        "id" => label_id,
        "name" => "Label 1",
        "color" => "green"
      }

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/labels/#{label_id}"),
            {}
          )
          .and_return(label_payload)
      )

      expect(client_mock).to(
        receive(:put)
          .with(
            req_path("/labels/#{label_id}"),
            {},
            {
              "name" => "Label 2",
              "color" => "red"
            }
          )
          .and_return("{}")
      )
    end

    execute_command("label edit " + label_id)

    output_string = interface.output.string

    expect(output_string).to match("Label has been updated.")
  end
end
