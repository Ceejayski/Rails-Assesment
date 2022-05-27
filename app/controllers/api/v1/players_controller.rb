# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

module Api
  module V1
    # `class Api::V1::PlayersController`
    class PlayersController < ApplicationController
      before_action :set_player, only: [:show, :update, :destroy]

      # GET "/players"
      def index
        players = Player.latest.paginate(page: params[:page], per_page: 10)
        render json: PlayerSerializer.new(players).serialize
      end

      private

      def player_params
        params.require(:player).permit(:first_name, :last_name, :number, :image)
      end

      def set_player
        @player = Player.find(params[:id])
      end
      
    end
  end
end
