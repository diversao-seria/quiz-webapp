class AddPasswordDigestAndNicknameToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :password_digest, :string
    add_column :players, :username, :string
  end
end
