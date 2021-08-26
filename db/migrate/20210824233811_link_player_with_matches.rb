class LinkPlayerWithMatches < ActiveRecord::Migration[6.0]
  def change
    add_reference :matches, :player, foreign_key: true
  end
end
