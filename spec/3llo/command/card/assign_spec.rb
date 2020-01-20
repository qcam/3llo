require "spec_helper"

describe "card assign <card_key>", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "assigns users to the card" do
    card_id = "card:1"
    board_id = "board:1"

    select_board($application, make_board(board_id))

    interface = make_interface($application) do |input, _output|
      expect(input).to(
        receive(:multi_select)
          .with(
            "Choose the users to assign this card to:",
            {"user1" => "user:1", "user2" => "user:2"},
            {default: [2], enum: "."}
          )
          .and_return(["user1", "user2"])
      )
    end

    make_client_mock($application) do |client_mock|
      card_payload = {
        "id" => card_id,
        "name" => "Card 1",
        "desc" => "The first card",
        "shortUrl" => "http://example.com/cards/1",
        "members" => [
          {"id" => "user:2", "username" => "user2"}
        ]
      }

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/cards/#{card_id}", list: true, members: true),
            {}
          )
          .and_return(card_payload)
          .once()
      )

      members_payload = [
        {"id" => "user:1", "username" => "user1"},
        {"id" => "user:2", "username" => "user2"}
      ]

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/board/#{board_id}/members"),
            {}
          )
          .and_return(members_payload)
          .once()
      )

      expect(client_mock).to(
        receive(:put)
          .with(
            req_path("/cards/#{card_id}/idMembers"),
            {},
            {"value" => "user1,user2"}
          )
          .and_return(card_payload)
          .once()
      )
    end

    execute_command("card assign " + card_id)

    output_string = interface.output.string

    expect(output_string).to match("Chosen members have been assigned to the card.")
  end
end
