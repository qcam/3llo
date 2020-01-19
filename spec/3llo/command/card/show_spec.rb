require "spec_helper"

describe "card show <card_key>", type: :integration do
  include IntegrationSpecHelper

  before { $container = build_container() }
  after { $container = nil }

  it "shows the information of the given cards" do
    card_id = "card:1"

    make_client_mock($container) do |client_mock|
      card_payload = {
        "id" => card_id,
        "name" => "Card 1",
        "desc" => "description",
        "shortUrl" => "http://example.com/cards/1"
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

      checklist_payload = [{
        "id" => "checklist:1",
        "name" => "Checklist 1",
        "checkItems" => [
          {"id" => "item:1", "name" => "Item 1", "state" => "incomplete"},
          {"id" => "item:2", "name" => "Item 2", "state" => "complete"}
        ]
      }]

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/cards/#{card_id}/checklists"),
            {}
          )
          .and_return(checklist_payload)
          .once()
      )
    end

    interface = make_interface($container)

    execute_command("card show " + card_id)

    card_shortcut = Tr3llo::Application.fetch_registry!().register(:card, card_id)

    output_string = interface.output.string

    expect(output_string).to match("Card 1")
    expect(output_string).to match("#" + card_shortcut)
    expect(output_string).to match("description")
    expect(output_string).to match("Checklist 1")
    expect(output_string).to match("Item 1")
    expect(output_string).to match("Item 2")
  end

  it "supports accessing using card shortcut" do
    card_id = "card:1"
    card_shortcut = Tr3llo::Application.fetch_registry!().register(:card, card_id)

    make_client_mock($container) do |client_mock|
      card_payload = {
        "id" => card_id,
        "name" => "Card 1",
        "desc" => "description",
        "shortUrl" => "http://example.com/cards/1"
      }

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/cards/#{card_id}", {"list" => "true", "members" => "true"}),
            {}
          )
          .and_return(card_payload)
          .once()
      )

      checklist_payload = [{
        "id" => "checklist:1",
        "name" => "Checklist 1",
        "checkItems" => []
      }]

      expect(client_mock).to(
        receive(:get)
          .with(
            req_path("/cards/#{card_id}/checklists"),
            {}
          )
          .and_return(checklist_payload)
          .once()
      )
    end

    make_interface($container)

    execute_command("card show #" + card_shortcut)
  end

  it "handles invalid card key" do
    interface = make_interface($container)

    execute_command("card show #random")

    output_string = interface.output.string
    expect(output_string).to match("\"#random\" is not a valid card key.")
  end
end
