class PlayersController < ApplicationController

  def index
    @player_id = params[:player_id]
    begin
      @player = Player.find(@player_id)
      @player.password_digest = "filtered"
      render json: @player
    rescue
      render json: {"mensagem": "Player não encontrado"}, status: :unprocessable_entity
    end
  end

  def create
    @player = Player.create(create_params)
    if @player.save
      render json: {"id": @player.id}, status: :created
    else
      render json: @player.errors.messages, status: :unprocessable_entity
    end
  end

  def create_params
    params.require(:player).permit(:name, :email, :password, :username)
  end

end
