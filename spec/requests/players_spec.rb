# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Players', type: :request do
  let(:json_data) { JSON.parse(response.body) }
  describe 'GET /players' do
    subject { get '/api/v1/players' }
    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end
    it 'should return list of players' do
      create_list :player, 4
      players = Player.latest
      subject
      expect(json_data['players'][3]).to eq({
                                              'id' => players[3].id,
                                              'last_name' => players[3].last_name,
                                              'first_name' => players[3].first_name,
                                              'number' => players[3].number,
                                              'image' => players[3].image_url
                                            })
    end
  end
end
