module Tr3llo
  module Presenter
    extend self

    def present_boards(boards)
      boards.map.with_index { |board, index| present_board(board, index) }
    end

    def present_board(board, index = 0)
      "#{index}. [#{board[:id].colorize(34)}] - #{board[:name]}"
    end

    def present_cards(cards)
      cards.map do |card|
        if card.has_key?(:list)
          list_str = "(#{card[:list][:name]}) ".colorize(95)
        else
          list_str = ''
        end

        if card.has_key?(:labels)
          label_str = card[:labels].map do |label|
            "##{label[:name]}".colorize(get_color(label[:color]))
          end.join(", ")
        else
          label_str = ''
        end

        "[#{card[:id].labelize}] - #{list_str}#{card[:name]} (#{label_str})"
      end
    end

    def present_card(card, detail = true)
      if card.has_key?(:labels)
        label_str = card[:labels].map do |label|
          "##{label[:name]}".colorize(get_color(label[:color]))
        end.join(", ")
      else
        label_str = ''
      end

      "ID: ".labelize + card[:id] + "\n" +
      "Name: ".labelize + card[:name] + " (#{label_str})" "\n" +
      "Description: ".labelize + card[:desc] + "\n" +
      "List: ".labelize + card[:list][:name] + "\n" +
      "Link: ".labelize + card[:shortUrl] + "\n"
    end

    def present_lists(lists)
      lists.map do |list|
        present_list(list)
      end
    end

    def present_list(list)
      "[#{list[:id].labelize}] - #{list[:name]}"
    end

    def help_menu
      %q{
    3llo - CLI for Trello

    Usage:
    board list                      - Show list of board
    board select <board_id>         - Show list of board
    card list                       - Show list of cards grouped by list
    card list mine                  - Show list of my cards
    card show <card_id>             - Show card information
    card move <card_id> <list_id>   - Move card to a list
    card self-assign <card_id>      - Self-assign a card
    list list                       - Show all lists
    help                            - Show help menu
    exit                            - Exit program
      }
    end

    private

    def get_color(color)
      case color
      when 'red' then 31
      when 'blue' then 34
      when 'green' then 32
      when 'black' then 37
      when 'purple' then 35
      when 'yellow', 'orange' then 33
      else 39
      end
    end
  end
end
