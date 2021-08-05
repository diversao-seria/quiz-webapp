class ChangePlayersReference < ActiveRecord::Migration[6.0]
  def change
    remove_column :matches, :player_id
  end
end
