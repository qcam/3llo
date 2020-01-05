require '3llo/commands/card/list'
require '3llo/commands/card/list_mine'
require '3llo/commands/card/show'
require '3llo/commands/card/move'
require '3llo/commands/card/self_assign'
require '3llo/commands/card/assign'
require '3llo/commands/card/invalid'
require '3llo/commands/card/comments'
require '3llo/commands/card/comment'
require '3llo/commands/card/add'
require '3llo/commands/card/archive'

module Tr3llo
  module CardCommandFactory
    extend self

    def execute(subcommand, args)
      case subcommand
      when 'list'
        is_mine, _ = *args
        board = Application.fetch_board!()
        user = Application.fetch_user!()

        if is_mine == 'mine'
          Command::Card::ListMineCommand.execute(board[:id], user[:id])
        elsif is_mine.nil?
          Command::Card::ListCommand.execute(board[:id])
        else
          command_string = "card list #{is_mine}"
          raise InvalidArgumentError.new("#{command_string.inspect} is not a valid command")
        end
      when 'add'
        board = Application.fetch_board!()
        Command::Card::AddCommand.execute(board[:id])
      when 'show'
        card_key, _ = args
        Utils.assert_string!(card_key, "card key is missing")

        Command::Card::ShowCommand.execute(card_key)
      when 'comments'
        card_key, _ = args
        Utils.assert_string!(card_key, "card key is missing")

        Command::Card::CommentsCommand.execute(card_key)
      when 'comment'
        card_key, _ = args
        Utils.assert_string!(card_key, "card key is missing")

        Command::Card::CommentCommand.execute(card_key)
      when 'move'
        board = Application.fetch_board!()
        card_key, _ = args
        Utils.assert_string!(card_key, "card key is missing")

        Command::Card::MoveCommand.execute(card_key, board[:id])
      when 'self-assign'
        user = Application.fetch_user!()
        card_key, _ = args
        Utils.assert_string!(card_key, "card key is missing")

        Command::Card::SelfAssignCommand.execute(card_key, user[:id])
      when 'assign'
        board = Application.fetch_board!()
        card_key, _ = args
        Utils.assert_string!(card_key, "card key is missing")

        Command::Card::AssignCommand.execute(card_key, board[:id])
      when 'archive'
        card_key, _ = args
        Utils.assert_string!(card_key, "card key is missing")

        Command::Card::ArchiveCommand.execute(card_key)
      else
        handle_invalid_subcommand(subcommand, args)
      end
    rescue InvalidArgumentError => exception
      Command::Card::InvalidCommand.execute(exception.message)
    rescue InvalidCommandError => exception
      Command::Card::InvalidCommand.execute(exception.message)
    rescue BoardNotSelectedError => exception
      Command::Card::InvalidCommand.execute(exception.message)
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
