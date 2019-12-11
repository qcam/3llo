# frozen_string_literal: true

require '3llo/commands/list/list'
require '3llo/commands/list/cards'
require '3llo/commands/list/invalid'
require '3llo/commands/list/archive_cards'

module Tr3llo
  class ListCommandFactory
    def initialize(subcommand, args)
      @subcommand = subcommand
      @args = args
    end

    def factory
      case subcommand
      when 'l'
        board_id = $container.resolve(:board)[:id]
        Command::List::ListCommand.new(board_id)
      when 'c'
        list_id, = args
        Command::List::CardsCommand.new(list_id)
      when 'archive-cards'
        list_id, = args
        Command::List::ArchiveCardsCommand.new(list_id)
      else
        Command::List::InvalidCommand.new
      end
    end

    private

    attr_reader :subcommand, :args
  end
end
