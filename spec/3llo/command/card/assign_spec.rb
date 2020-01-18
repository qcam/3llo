require "spec_helper"

describe "card assign <card_key>", type: :integration do
  include IntegrationSpecHelper

  before { $container = build_container() }
  after { $container = nil }

  it "assigns users to the card" do
    card_id = "card:1"
    board_id = "board:1"

    select_board($container, make_board(board_id))

    interface = make_interface($container) do |input, _output|
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

    make_client_mock($container) do |client_mock|
      card_json = JSON.dump({
        "id" => card_id,
        "name" => "Card 1",
        "desc" => "The first card",
        "shortUrl" => "http://example.com/cards/1",
        "members" => [
          {"id" => "user:2", "username" => "user2"}
        ]
      })
      expect(client_mock).to(
        receive(:get)
          .with(
            "/cards/#{card_id}",
            {key: "foo", token: "bar", list: true, members: true}
          )
          .and_return(card_json)
          .once()
      )

      members_json = JSON.dump([
        {"id" => "user:1", "username" => "user1"},
        {"id" => "user:2", "username" => "user2"}
      ])

      expect(client_mock).to(
        receive(:get)
          .with(
            "/board/#{board_id}/members",
            {key: "foo", token: "bar"}
          )
          .and_return(members_json)
          .once()
      )

      expect(client_mock).to(
        receive(:put)
          .with(
            "/cards/#{card_id}/idMembers",
            {key: "foo", token: "bar", value: "user1,user2"}
          )
          .and_return(card_json)
          .once()
      )
    end

    execute_command("card assign " + card_id)

    output_string = interface.output.string

    expect(output_string).to match("Chosen members have been assigned to the card.")
  end
end
