class CreateAlternatives < ActiveRecord::Migration[6.0]
  def change
    create_table :alternatives do |t|
      t.references :question, foreign_key: true
      t.string :text
      t.boolean :correct

      t.timestamps
    end
  end
end
