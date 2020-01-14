require "spec_helper"

describe "card list", type: :integration do
  include IntegrationSpecHelper

  before { $container = build_container() }
  after { $container = nil}

  it "requires board to be selected" do
    interface = make_interface($container)

    execute_command("card list")

    output_string = interface.output.string
    expect(output_string).to match("Board has not been selected.")
  end

  it "lists all cards in the selected board" do
    interface = make_interface($container)

    select_board($container, make_board("board:1"))

    make_client_mock($container) do |client_mock|
      lists_json = JSON.dump([
        {"id" => "list:1", "name" => "List 1"},
        {"id" => "list:2", "name" => "List 2"}
      ])

      expect(client_mock).to(
        receive(:get)
          .with("/boards/board:1/lists", {key: "foo", token: "bar", list: true})
          .and_return(lists_json)
          .once()
      )

      list1_card_json = JSON.dump([
        {
          "id" => "card:1",
          "name" => "Card 1",
          "desc" => "first card",
          "shortUrl" => "https://example.com/cards/1"
        }
      ])

      expect(client_mock).to(
        receive(:get)
          .with("/lists/list:1/cards", {key: "foo", token: "bar", member_fields: "id,username", members: "true"})
          .and_return(list1_card_json)
          .once()
      )

      list2_card_json = JSON.dump([
        {
          "id" => "card:2",
          "name" => "Card 2",
          "desc" => "second card",
          "shortUrl" => "https://example.com/cards/2"
        }
      ])

      expect(client_mock).to(
        receive(:get)
          .with(
            "/lists/list:2/cards",
            {
              key: "foo",
              token: "bar",
              member_fields: "id,username",
              members: "true"
            }
          )
          .and_return(list2_card_json)
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
