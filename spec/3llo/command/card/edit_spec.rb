require "spec_helper"

describe "card edit <card_key>", type: :integration do
  include IntegrationSpecHelper

  before { $container = build_container() }
  after { $container = nil }

  it "updates the card" do
    card_id = "card:1"
    board_id = "board:1"

    select_board($container, make_board(board_id))

    interface = make_interface($container) do |input, _output|
      expect(input).to receive(:ask).with("Name:", required: true, value: "Card 1").and_return("Card 2")
      expect(input).to receive(:ask).with("Description:", value: "The first card").and_return("The second card")
    end

    make_client_mock($container) do |client_mock|
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
            req_path("/cards/#{card_id}", {list: true, members: true}),
            {}
          )
          .and_return(card_payload)
          .once()
      )

      expect(client_mock).to(
        receive(:put)
          .with(
            req_path("/cards/#{card_id}"),
            {},
            {
              "name" => "Card 2",
              "desc" => "The second card"
            }
          )
          .and_return("{}")
          .once()
      )
    end

    execute_command("card edit " + card_id)

    output_string = interface.output.string

    expect(output_string).to match("Card has been updated.")
  end
end
