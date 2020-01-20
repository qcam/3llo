require "spec_helper"

describe "board list", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "lists all open boards by member ID" do
    user_id = "user:1"

    # Mock HTTP request.
    make_client_mock($application) do |client_mock|
      payload = [
        {"id" => "board:1", "name" => "Board 1"},
        {"id" => "board:2", "name" => "Board 2"}
      ]

      expect(client_mock).to(
        receive(:get)
        .with(
          Tr3llo::Utils.build_req_path(
            "/members/#{user_id}/boards",
            {filter: "open"}
          ),
          {}
        )
        .and_return(payload)
      )
    end

    interface = make_interface($application)

    $application.register(:user, Tr3llo::Entities::User.new(user_id))

    execute_command("board list")

    board1_shortcut = $application.resolve(:registry).register(:board, "board:1")
    board2_shortcut = $application.resolve(:registry).register(:board, "board:2")

    output_string = interface.output.string

    expect(output_string).to match("Board 1")
    expect(output_string).to match("Board 2")
    expect(output_string).to match("board:1")
    expect(output_string).to match("board:2")
    expect(output_string).to match("#" + board1_shortcut)
    expect(output_string).to match("#" + board2_shortcut)
  end
end
