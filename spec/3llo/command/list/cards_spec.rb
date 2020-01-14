require "spec_helper"

describe "list cards", type: :integration do
  include IntegrationSpecHelper

  before { $container = build_container() }
  after { $container = nil }

  it "lists all cards that belong to the list" do
    list_id = "list:1"

    make_client_mock($container) do |client_mock|
      json = JSON.dump([
        {
          "id" => "card:1",
          "name" => "Card 1",
          "desc" => "first card",
          "shortUrl" => "https://example.com/cards/1"
        },
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
          "/lists/#{list_id}/cards",
          {key: "foo", token: "bar", member_fields: "id,username", members: "true"}
        )
        .and_return(json)
      )
    end

    interface = make_interface($container)

    execute_command("list cards " + list_id)

    output_string = interface.output.string

    expect(output_string).to match("card:1")
    expect(output_string).to match("Card 1")
    expect(output_string).to match("card:2")
    expect(output_string).to match("Card 2")
  end
end
