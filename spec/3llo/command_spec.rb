require "spec_helper"

describe Tr3llo::Command do
  describe ".generate_suggestions" do
    it "generates suggestions" do
      assert_suggestions("", "", %w[board list card label help exit])

      assert_suggestions("b", "b", ["board"])
      assert_suggestions("", "board ", %w[add list select])
      assert_suggestions("se", "board se", ["select"])
      assert_suggestions("l", "board l", ["list"])

      assert_suggestions("l", "l", ["list", "label"])
      assert_suggestions("", "list ", %w[list add cards archive-cards])
      assert_suggestions("a", "list a", ["add", "archive-cards"])
      assert_suggestions("ca", "list ca", ["cards"])
      assert_suggestions("l", "list l", ["list"])

      assert_suggestions("c", "c", ["card"])
      assert_suggestions(
        "",
        "card ",
        %w[
          list show add edit archive list-mine move
          comment comments self-assign assign
          add-checklist edit-checklist remove-checklist
          add-item edit-item remote-item check-item uncheck-item add-label
        ]
      )
      assert_suggestions("l", "card l", ["list", "list-mine"])
      assert_suggestions("a", "card a", %w[add archive assign add-checklist add-item add-label])
      assert_suggestions("e", "card e", %w[edit edit-checklist edit-item])
      assert_suggestions("l", "label l", ["list"])
      assert_suggestions("a", "label a", ["add"])
      assert_suggestions("e", "label e", ["edit"])
      assert_suggestions("r", "label r", ["remove"])
    end

    def assert_suggestions(buffer, line_buffer, expected_suggestions)
      actual_suggestions = described_class.generate_suggestions(buffer, line_buffer)

      expect(actual_suggestions).to eq(expected_suggestions)
    end
  end
end
