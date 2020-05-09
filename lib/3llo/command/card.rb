require "3llo/command/card/list"
require "3llo/command/card/list_mine"
require "3llo/command/card/edit"
require "3llo/command/card/show"
require "3llo/command/card/move"
require "3llo/command/card/self_assign"
require "3llo/command/card/assign"
require "3llo/command/card/invalid"
require "3llo/command/card/comments"
require "3llo/command/card/comment"
require "3llo/command/card/add"
require "3llo/command/card/archive"
require "3llo/command/card/add_checklist"
require "3llo/command/card/edit_checklist"
require "3llo/command/card/remove_checklist"
require "3llo/command/card/add_item"
require "3llo/command/card/check_item"
require "3llo/command/card/uncheck_item"
require "3llo/command/card/edit_item"
require "3llo/command/card/remove_item"
require "3llo/command/card/add_label"

module Tr3llo
  module Command
    module Card
      extend self

      def execute(subcommand, args)
        case subcommand
        when "list"
          board = Application.fetch_board!()

          Command::Card::List.execute(board.id)
        when "list-mine"
          board = Application.fetch_board!()
          user = Application.fetch_user!()

          Command::Card::ListMine.execute(board.id, user.id)
        when "add"
          board = Application.fetch_board!()
          Command::Card::Add.execute(board[:id])
        when "show"
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::Show.execute(card_key)
        when "edit"
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::Edit.execute(card_key)
        when "comments"
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::Comments.execute(card_key)
        when "comment"
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::Comment.execute(card_key)
        when "move"
          board = Application.fetch_board!()
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::Move.execute(card_key, board[:id])
        when "self-assign"
          user = Application.fetch_user!()
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::SelfAssign.execute(card_key, user[:id])
        when "assign"
          board = Application.fetch_board!()
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::Assign.execute(card_key, board[:id])
        when "archive"
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::Archive.execute(card_key)
        when "add-checklist"
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::AddChecklist.execute(card_key)
        when "edit-checklist"
          checklist_key, = args
          Utils.assert_string!(checklist_key, "checklist key is missing")

          Command::Card::EditChecklist.execute(checklist_key)
        when "remove-checklist"
          checklist_key, = args
          Utils.assert_string!(checklist_key, "checklist key is missing")

          Command::Card::RemoveChecklist.execute(checklist_key)
        when "add-item"
          checklist_key, = args
          Utils.assert_string!(checklist_key, "checklist key is missing")

          Command::Card::AddItem.execute(checklist_key)
        when "check-item"
          card_key, check_item_key, = args
          Utils.assert_string!(card_key, "card key is missing")
          Utils.assert_string!(check_item_key, "item key is missing")

          Command::Card::CheckItem.execute(card_key, check_item_key)
        when "uncheck-item"
          card_key, check_item_key, = args
          Utils.assert_string!(card_key, "card key is missing")
          Utils.assert_string!(check_item_key, "item key is missing")

          Command::Card::UncheckItem.execute(card_key, check_item_key)
        when "edit-item"
          card_key, check_item_key, = args
          Utils.assert_string!(card_key, "card key is missing")
          Utils.assert_string!(check_item_key, "item key is missing")

          Command::Card::EditItem.execute(card_key, check_item_key)
        when "remove-item"
          card_key, check_item_key, = args
          Utils.assert_string!(card_key, "card key is missing")
          Utils.assert_string!(check_item_key, "item key is missing")

          Command::Card::RemoveItem.execute(card_key, check_item_key)
        when "add-label"
          board = Application.fetch_board!()
          card_key, = args
          Utils.assert_string!(card_key, "card key is missing")

          Command::Card::AddLabel.execute(card_key, board[:id])
        else
          handle_invalid_subcommand(subcommand, args)
        end
      rescue InvalidArgumentError => exception
        Command::Card::Invalid.execute(exception.message)
      rescue InvalidCommandError => exception
        Command::Card::Invalid.execute(exception.message)
      rescue BoardNotSelectedError => exception
        Command::Card::Invalid.execute(exception.message)
      end

      private

      def handle_invalid_subcommand(subcommand, _args)
        case subcommand
        when String
          command_string = "card #{subcommand}"

          raise InvalidCommandError.new("#{command_string.inspect} is not a valid command")
        when NilClass
          raise InvalidCommandError.new("command is missing")
        end
      end
    end
  end
end
