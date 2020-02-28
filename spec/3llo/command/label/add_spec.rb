require "spec_helper"

describe "label add", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "creates a new label" do
    board_id = "board:1"

    select_board($application, make_board(board_id))

    make_client_mock($application) do |client_mock|
      expect(client_mock).to(
        receive(:post)
          .with(
            req_path("/labels"),
            _headers = {},
            _payload = {
              "name" => "Label 1",
              "color" => "red",
              "idBoard" => board_id
            }
          )
          .and_return("{}")
      )
    end

    interface = make_interface($application) do |input, _output|
      expect(input).to(
        receive(:select)
          .with(
            "Choose the color:",
            Tr3llo::Utils::TRELLO_LABEL_COLOR
          )
          .and_return("red")
      )

      expect(input).to receive(:ask).with("Name:", required: true).and_return("Label 1")
    end

    execute_command("label add")

    output_string = interface.output.string

    expect(output_string).to match("Label has been created.")
  end
end
