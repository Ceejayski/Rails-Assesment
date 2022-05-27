# frozen_string_literal: true

# PlayerSerializer
class PlayerSerializer < Struct.new(:player_record)
  def serialize
    unless player_record.class.name == 'ActiveRecord::Relation'
      return {
        error: false,
        data: { **single_player_hash(player_record) }
      }
    end

    player_collection_hash
  end

  def single_player_hash(player)
    {
      id: player.id,
      first_name: player.first_name,
      last_name: player.last_name,
      number: player.number,
      image: player.image_url
    }
  end

  def player_collection_hash
    players = player_record.map do |single_player|
      single_player_hash(single_player)
    end
    {
      players: players,
      pagination: {
        current_page: players_link_helper(page: player_record.current_page),
        next_page: player_record.next_page ? players_link_helper(page: player_record.next_page) : nil,
        total_pages: player_record.total_pages,
        total_count: players.count
      },
      error: false
    }
  end

  def players_link_helper(params)
    Rails.application.routes.url_helpers.api_v1_players_path(params)
  end
end
