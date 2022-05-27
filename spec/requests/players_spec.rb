# frozen_string_literal: true

require 'rails_helper'

# namespace "api/v1"
RSpec.describe 'Players', type: :request do
  let(:player) { create :player }
  let(:json_data) { JSON.parse(response.body) }
  let(:valid_image) do
    Rack::Test::UploadedFile.new('spec/fixtures/sample.jpg', 'image/jpg')
  end
  let(:invalid_image) do
    Rack::Test::UploadedFile.new('spec/fixtures/invalid_sample.txt', 'text/plain')
  end
  let(:valid_params) do
    { first_name: Faker::Name.name, last_name: Faker::Name.name, number: Faker::Number.between(from: 0, to: 99),
      image: valid_image }
  end
  let(:invalid_params) { { first_name: 'test', last_name: nil, number: 200, image: invalid_image } }
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

    it 'should paginate results' do
      create_list :player, 20
      get '/api/v1/players?page=2'
      expect(json_data['players'].length).to eq(10)
      expect(json_data['pagination']['total_pages']).to eq(2)
    end
  end

  describe 'POST /players' do
    let(:params) { valid_params }
    subject { post '/api/v1/players', params: params }

    context '#Invalid Params' do
      let(:params) { { first_name: 'test', last_name: nil, number: 90, image: valid_image } }
      subject { post '/api/v1/players', params: params }
      it 'should return unproccessable_entity response status' do
        params = {}
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'should return error response if last_name is nil' do
        subject
        expect(json_data['errors']['last_name']).to eq(["can't be blank"])
      end
      it 'should return error response if number is greater than 100' do
        params[:number] = 101
        subject
        expect(json_data['errors']['number']).to eq(['must be less than or equal to 99'])
      end

      it 'should return and error if image is invalid' do
        params[:image] = invalid_image
        subject
        expect(json_data['errors']['image']).to eq(['has an invalid content type'])
      end
    end

    context '#Valid Params' do
      it 'should return created response status' do
        subject
        expect(response).to have_http_status(:created)
      end
      it 'should increase Players count by 1' do
        expect { subject }.to change { Player.count }.by(1)
      end
      it 'should return new player details' do
        subject
        expect(json_data['data']).to eq({ 'first_name' => params[:first_name],
                                          'id' => Player.last.id,
                                          'image' => Player.last.image_url,
                                          'last_name' => params[:last_name],
                                          'number' => params[:number] })
      end
    end
  end

  describe 'PUT /players/:id' do
    let(:params) { { **valid_params, image: nil } }
    let(:id) { player.id }
    subject { put "/api/v1/players/#{id}", params: params }
    context '#Invalid Params' do
      let(:params) { { first_name: 'test', last_name: nil, number: 90 } }
      describe 'invalid record' do
        subject { put '/api/v1/players/:id' }
        it 'should return not_found response status if reocrd id is invlaid' do
          subject
          expect(response).to have_http_status(:not_found)
          expect(json_data['message']).to eq("Couldn't find Player with 'id'=:id")
        end
      end

      it 'should return error response if number is greater than 100' do
        params[:number] = 101
        subject
        expect(json_data['errors']['number']).to eq(['must be less than or equal to 99'])
      end

      it 'should return and error if image is invalid' do
        params[:image] = invalid_image
        subject
        expect(json_data['errors']['image']).to eq(['has an invalid content type'])
      end
    end
    context '#Valid Params' do
      it 'should return created response status' do
        subject
        expect(response).to have_http_status(:ok)
      end
      it 'should increase Players count by 1' do
        expect { subject }.to change { Player.last }
      end
      it 'should return new player details' do
        subject
        expect(json_data['data']).to eq({ 'first_name' => params[:first_name],
                                          'id' => player.id,
                                          'image' => '',
                                          'last_name' => params[:last_name],
                                          'number' => params[:number] })
      end
    end
  end

  describe 'DELETE /players/:id' do
    context '#invalid record' do
      subject { delete '/api/v1/players/:id' }
      it 'should return not_found response status if reocrd id is invlaid' do
        subject
        expect(response).to have_http_status(:not_found)
        expect(json_data['message']).to eq("Couldn't find Player with 'id'=:id")
      end
    end
    context '#valid record' do
      subject { delete "/api/v1/players/#{player.id}" }
      it 'should return created response status' do
        subject
        expect(response).to have_http_status(:ok)
        expect(json_data['message']).to eq('Player deleted successfully')
      end
    end
  end
end
