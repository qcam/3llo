require "spec_helper"

describe "card add", type: :integration do
  include IntegrationSpecHelper

  before { $container = build_container() }
  after { $container = nil }

  it "creates a new card" do
    board_id = "board:1"
    list_id = "list:1"

    select_board($container, make_board(board_id))

    make_client_mock($container) do |client_mock|
      lists_json = JSON.dump([
        {"id" => "list:1", "name" => "List 1"},
        {"id" => "list:2", "name" => "List 2"}
      ])

      expect(client_mock).to(
        receive(:get)
          .with("/boards/#{board_id}/lists", {key: "foo", token: "bar", list: true})
          .and_return(lists_json)
      )

      expect(client_mock).to(
        receive(:post)
          .with(
            "/cards",
            {
              key: "foo",
              token: "bar",
              name: "Card 1",
              desc: "The first card",
              idList: list_id
            }
          )
          .and_return("{}")
      )
    end

    interface = make_interface($container) do |input, _output|
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
      expect(input).to receive(:ask).with("Description:").and_return("The first card")

    end

    execute_command("card add")

    output_string = interface.output.string

    expect(output_string).to match("Card has been created.")
  end
end
