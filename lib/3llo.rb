require "3llo/version"
require "core_ext"
require "3llo/client"
require "3llo/presenter"
require "3llo/interface"
require 'json'

module Tr3llo
  extend self

  USER_ID = ENV.fetch('TRELLO_USER') { raise "Have you set TRELLO_USER?" }
  KEY = ENV.fetch('TRELLO_KEY') { raise "Have you set TRELLO_KEY?" }
  TOKEN = ENV.fetch('TRELLO_TOKEN') { raise "Have you set TRELLO_TOKEN?" }

  def list_boards
    JSON.parse(
      client.get(
        "/members/#{USER_ID}/boards",
        key: KEY,
        token: TOKEN,
      ),
      symbolize_names: true
    )
  end

  def select_board(board_id)
    $board_id = board_id
  end

  def load_me!
    url = "/members/#{USER_ID}"

    $user = JSON.parse(
      client.get(
        url,
        key: KEY,
        token: TOKEN
      ),
      symbolize_names: true
    )
  end

  def list_cards(member_id = 'all')
    if member_id == 'mine'
      url = "/boards/#{$board_id}/members/#{USER_ID}/cards"
    else
      url = "/boards/#{$board_id}/cards"
    end

    JSON.parse(
      client.get(
        url,
        list: true,
        key: KEY,
        token: TOKEN
      ),
      symbolize_names: true
    )
  end

  def show_card(card_id)
    url = "/cards/#{card_id}"

    JSON.parse(
      client.get(
        url,
        list: 'true',
        key: KEY,
        token: TOKEN
      ),
      symbolize_names: true
    )
  end

  def list_list_cards(list_id)
    url = "/lists/#{list_id}/cards"

    JSON.parse(
      client.get(
        url,
        key: KEY,
        token: TOKEN
      ),
      symbolize_names: true
    )
  end

  def list_lists
    JSON.parse(
      client.get(
        "/boards/#{$board_id}/lists/",
        list: true,
        key: KEY,
        token: TOKEN
      ),
      symbolize_names: true
    )
  end

  def move_card(card_id, list_id)
    url = "/cards/#{card_id}/idList"
    JSON.parse(
      client.put(
        url,
        key: KEY,
        list: true,
        token: TOKEN,
        value: list_id
      ),
      symbolize_names: true
    )
  end

  def self_assign_card(card_id)
    url = "/cards/#{card_id}/idMembers"
    JSON.parse(
      client.put(
        url,
        key: KEY,
        token: TOKEN,
        value: $user[:id]
      ),
      symbolize_names: true
    )
  end
  private

  def client
    Tr3llo::Client
  end
end
