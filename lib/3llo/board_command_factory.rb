# frozen_string_literal: true

require '3llo/commands/board/list'
require '3llo/commands/board/select'
require '3llo/commands/board/invalid'

module Tr3llo
  class BoardCommandFactory
    def initialize(subcommand, _)
      @subcommand = subcommand
    end

    def factory
      case subcommand
      when 'l'
        user_id = $container.resolve(:user)[:id]
        Command::Board::ListCommand.new(user_id)
      when 's'
        Command::Board::SelectCommand.new
      else
        Command::Board::InvalidCommand.new
      end
    end

    private

    attr_reader :subcommand
  end
end
