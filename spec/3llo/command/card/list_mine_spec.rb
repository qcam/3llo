require "spec_helper"

describe "card list mine", type: :integration do
  include IntegrationSpecHelper

  before { $container = build_container() }
  after { $container = nil }

  it "requires board to be selected" do
    interface = make_interface($container)

    execute_command("card list mine")

    output_string = interface.output.string
    expect(output_string).to match("Board has not been selected.")
  end

  it "lists all cards assigned to the user" do
    interface = make_interface($container)

    select_board($container, make_board("board:1"))
    sign_in($container, make_user("user:1"))

    make_client_mock($container) do |client_mock|
      card_json = JSON.dump([
        {
          "id" => "card:1",
          "name" => "Card 1",
          "desc" => "first card",
          "shortUrl" => "https://example.com/cards/1",
          "list" => {
            "id" => "list:1",
            "name" => "List 1"
          }
        }
      ])

      expect(client_mock).to(
        receive(:get)
          .with("/boards/board:1/members/user:1/cards", {key: "foo", token: "bar", list: true})
          .and_return(card_json)
          .once()
      )
    end

    execute_command("card list mine")

    output_string = interface.output.string

    expect(output_string).to match("card:1")
    expect(output_string).to match("Card 1")
  end
end
