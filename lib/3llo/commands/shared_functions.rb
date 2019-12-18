# frozen_string_literal: true

module Tr3llo
  module Command
      class SharedFunctions
        # load all lists of a certain board
        def self.load_lists(board_id)
          @list_id = interface.input.select(
            'Choose a list:',
            API::List
              .find_all_by_board(board_id)
              .map { |list| [list[:name], list[:id]] }
              .to_h
          )
        end

        # Ask for the card to be selected
        def self.select_card
          @card_id = interface.input.select(
            'Select the card:',
            card_choices(@list_id)
          )
        end

        # Display all the cards in a certain list
        def self.card_choices(list_id)
          API::Card
            .find_all_by_list(list_id)
            .map { |card| [card[:name], card[:id]] }
            .to_h
        end

        def self.load_card(card_id)
          API::Card.find(card_id)
        end

        private

        def self.interface
          $container.resolve(:interface)
        end
      end
  end
end
