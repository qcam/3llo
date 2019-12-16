# frozen_string_literal: true

require '3llo/commands/card/list'
require '3llo/commands/card/list_mine'
require '3llo/commands/card/show'
require '3llo/commands/card/edit'
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
      when 'list', 'l'
        is_mine, = *args
        board_id = $container.resolve(:board)[:id]

        if is_mine == 'mine'
          user_id = $container.resolve(:user)[:id]
          Command::Card::ListMineCommand.new(board_id, user_id)
        else
          Command::Card::ListCommand.new(board_id)
        end
      when 'add', 'a'
        board_id = $container.resolve(:board)[:id]
        Command::Card::AddCommand.new(board_id)
      when 'show', 's'
        board_id = $container.resolve(:board)[:id]
        Command::Card::ShowCommand.new(board_id)
      when 'edit', 'e'
        board_id = $container.resolve(:board)[:id]
        Command::Card::EditCommand.new(board_id)
      when 'comments', 'cs'
        board_id = $container.resolve(:board)[:id]
        Command::Card::CommentsCommand.new(board_id)
      when 'comment', 'c'
        board_id = $container.resolve(:board)[:id]
        Command::Card::CommentCommand.new(board_id)
      when 'move', 'm'
        card_id, = args
        board_id = $container.resolve(:board)[:id]
        Command::Card::MoveCommand.new(board_id)
      when 'self-assign', 'sa'
        user_id = $container.resolve(:user)[:id]
        board_id = $container.resolve(:board)[:id]
        Command::Card::SelfAssignCommand.new(user_id, board_id)
      when 'assign', 'asg'
        card_id, = args
        board_id = $container.resolve(:board)[:id]
        Command::Card::AssignCommand.new(card_id, board_id)
      when 'archive', 'ar'
        board_id = $container.resolve(:board)[:id]
        Command::Card::ArchiveCommand.new(board_id)
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
