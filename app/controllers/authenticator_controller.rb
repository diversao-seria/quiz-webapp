class AuthenticatorController < ApplicationController

  def authenticate
    player = helpers.playerIdentifier(params[:login])
    command = AuthenticateUser.call(player, params[:password])

    if command.success?
      render json: { auth_token: command.result, player_id: player.id}
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end