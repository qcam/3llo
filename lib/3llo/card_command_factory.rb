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
  class CardCommandFactory
    def initialize(subcommand, args)
      @subcommand = subcommand
      @args = args
    end

    def factory
      case subcommand
      when 'list'
        is_mine, _ = *args
        board_id = $container.resolve(:board)[:id]

        if is_mine == 'mine'
          user_id = $container.resolve(:user)[:id]
          Command::Card::ListMineCommand.new(board_id, user_id)
        else
          Command::Card::ListCommand.new(board_id)
        end
      when 'add'
        board_id = $container.resolve(:board)[:id]
        Command::Card::AddCommand.new(board_id)
      when 'show'
        card_id, _ = args
        Command::Card::ShowCommand.new(card_id)
      when 'comments'
        card_id, _ = args
        Command::Card::CommentsCommand.new(card_id)
      when 'comment'
        card_id, _ = args
        Command::Card::CommentCommand.new(card_id)
      when 'move'
        card_id, _ = args
        board_id = $container.resolve(:board)[:id]
        Command::Card::MoveCommand.new(card_id, board_id)
      when 'self-assign'
        card_id, _ = args
        user_id = $container.resolve(:user)[:id]
        Command::Card::SelfAssignCommand.new(card_id, user_id)
      when 'assign'
        card_id, _ = args
        board_id = $container.resolve(:board)[:id]
        Command::Card::AssignCommand.new(card_id, board_id)
      when 'archive'
        card_id, _ = args
        Command::Card::ArchiveCommand.new(card_id)
      else
        Command::Card::InvalidCommand.new
      end
    rescue Container::KeyNotFoundError
      Command::ErrorCommand.new
    end

    private

    attr_reader :subcommand, :args
  end
end
