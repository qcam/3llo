require "spec_helper"

describe "board add", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "creates a new board" do
    make_client_mock($application) do |client_mock|
      expect(client_mock).to(
        receive(:post)
          .with(
            req_path("/boards"),
            _headers = {},
            _payload = {
              "name" => "Board 1",
              "desc" => "Board description",
              "defaultLists" => "true"
            }
          )
          .and_return("{}")
      )
    end

    interface = make_interface($application) do |input, _output|
      expect(input).to(
        receive(:yes?)
          .with("Create a default lists (To Do, Doing, Done) on this board?")
          .and_return("true")
      )

      expect(input).to receive(:ask).with("Name:", required: true).and_return("Board 1")
      expect(input).to receive(:ask).with("Description:").and_return("Board description")
    end

    execute_command("board add")

    output_string = interface.output.string

    expect(output_string).to match("Board has been created.")
  end
end
