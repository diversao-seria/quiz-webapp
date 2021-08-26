module AuthenticatorHelper
  def playerIdentifier(login)
    if login =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
      player = Player.where(email: login).take
    else
      player = Player.where(username: login).take
    end
    return player
  end
end
