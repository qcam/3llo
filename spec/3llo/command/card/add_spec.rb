require "spec_helper"

describe "card add", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "creates a new card" do
    board_id = "board:1"
    list_id = "list:1"

    select_board($application, make_board(board_id))

    make_client_mock($application) do |client_mock|
      lists_payload = [
        {"id" => "list:1", "name" => "List 1"},
        {"id" => "list:2", "name" => "List 2"}
      ]

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/boards/#{board_id}/lists", {list: true}),
            {}
          )
          .and_return(lists_payload)
      )

      expect(client_mock).to(
        receive(:post)
          .with(
            req_path("/cards"),
            _headers = {},
            _payload = {
              "name" => "Card 1",
              "desc" => "The first card",
              "idList" => list_id
            }
          )
          .and_return({})
      )
    end

    interface = make_interface($application) do |input, _output|
      expect(input).to(
        receive(:select)
          .with(
            "Choose the list this card should belong to:",
            {"List 1" => "list:1", "List 2" => "list:2"}
          )
          .and_return(list_id)
          .once()
      )

      expect(input).to receive(:ask).with("Name:", required: true).and_return("Card 1")
      expect(input).to receive(:multiline).with("Description:").and_return(["The first card"])
    end

    execute_command("card add")

    output_string = interface.output.string

    expect(output_string).to match("Card has been created.")
  end
end
