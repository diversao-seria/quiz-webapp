class AuthenticateUser
  prepend SimpleCommand

  def initialize(login, password)
    @login = login
    @password = password
  end

  def call
    JsonWebToken.encode(player_id: player.id) if player
  end

  private
  attr_accessor :login, :password

  def player

    player = login
    return player if player && player.authenticate(password)

    errors.add :player_authentication, 'invalid credentials'
    nil
  end
end