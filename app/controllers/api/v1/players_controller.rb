# frozen_string_literal: true

module Api
  module V1
    # `class Api::V1::PlayersController`
    class PlayersController < ApplicationController
      before_action :set_player, only: %i[update destroy]

      # GET "api/v1/players"
      def index
        players = Player.latest.paginate(page: params[:page], per_page: 10)
        render json: PlayerSerializer.new(players).serialize
      end

      # POST "api/v1/players"
      def create
        player = Player.new(player_params)
        player.save!
        render json: PlayerSerializer.new(player).serialize, status: :created
      rescue ActiveRecord::ActiveRecordError => e
        render json: player_error_parser(player.errors), status: :unprocessable_entity
      end

      # PUT "api/v1/players/:id"
      def update
        @player.update!(player_params)
        render json: PlayerSerializer.new(@player).serialize
      rescue ActiveRecord::ActiveRecordError
        render json: player_error_parser(@player.errors), status: :unprocessable_entity
      end

      # DELETe "api/v1/players/:id"
      def destroy
        @player.destroy
        render json: { message: 'Player deleted successfully', error: false }
      end

      private

      def player_params
        params.permit(:first_name, :last_name, :number, :image)
      end

      def set_player
        @player = Player.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { message: e, error: true }, status: :not_found
      end

      def player_error_parser(error)
        {
          message: 'Player could not saved, please check errors for more info',
          error: true,
          errors: error
        }
      end
    end
  end
end
