class PlayersController < ApplicationController

  def index
    @player_id = params[:player_id]
    @players = Match.where(player_id: @player_id)
    render json: @players
  end

  def create
    @player = Player.create(create_params)
    if @player.save
      head :created
    else
      render json: @player.errors.messages, status: :unprocessable_entity
    end
  end

  def create_params
    params.fetch(:player).permit(:name, :email, :password, :username)
  end

end
