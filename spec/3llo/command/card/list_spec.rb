require "spec_helper"

describe "card list", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "requires board to be selected" do
    interface = make_interface($application)

    execute_command("card list")

    output_string = interface.output.string
    expect(output_string).to match("Board has not been selected.")
  end

  it "lists all cards in the selected board" do
    interface = make_interface($application)

    select_board($application, make_board("board:1"))

    make_client_mock($application) do |client_mock|
      lists_payload = [
        {"id" => "list:1", "name" => "List 1"},
        {"id" => "list:2", "name" => "List 2"}
      ]

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/boards/board:1/lists", {list: true}),
            {}
          )
          .and_return(lists_payload)
          .once()
      )

      list1_card_payload = [
        {
          "id" => "card:1",
          "name" => "Card 1",
          "desc" => "first card",
          "shortUrl" => "https://example.com/cards/1"
        }
      ]

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/lists/list:1/cards", {members: "true", member_fields: "id,username"}),
            {}
          )
          .and_return(list1_card_payload)
          .once()
      )

      list2_card_payload = [
        {
          "id" => "card:2",
          "name" => "Card 2",
          "desc" => "second card",
          "shortUrl" => "https://example.com/cards/2"
        }
      ]

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/lists/list:2/cards", {members: "true", member_fields: "id,username"}),
            {}
          )
          .and_return(list2_card_payload)
          .once()
      )
    end

    execute_command("card list")

    output_string = interface.output.string

    expect(output_string).to match("card:1")
    expect(output_string).to match("card:2")
    expect(output_string).to match("Card 1")
    expect(output_string).to match("Card 2")
  end
end
