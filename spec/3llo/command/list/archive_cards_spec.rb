require "spec_helper"

describe "list archive-cards <list_key>", type: :integration do
  include IntegrationSpecHelper

  before { $application = build_container() }
  after { $application = nil }

  it "lists all cards that belong to the list" do
    list_id = "list:1"

    make_client_mock($application) do |client_mock|
      payload = [
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
      ]

      expect(client_mock).to(
        receive(:post)
        .with(req_path("/lists/#{list_id}/archiveAllCards"), {}, {})
        .and_return(payload)
      )
    end

    interface = make_interface($application) do |input, _output|
      expect(input).to(
        receive(:yes?)
          .with("Are you sure you want to archive all cards?")
          .and_return(true)
      )
    end

    execute_command("list archive-cards " + list_id)

    output_string = interface.output.string

    expect(output_string).to match("All cards on the list have been archived")
  end
end
