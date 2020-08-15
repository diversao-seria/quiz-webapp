class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.references :quiz, foreign_key: true
      t.references :player, foreign_key: true
      t.jsonb :results

      t.timestamps
    end
  end
end
