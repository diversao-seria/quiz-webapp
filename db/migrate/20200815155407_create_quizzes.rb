class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.references :user, foreign_key: true
      t.string :code
      t.jsonb :questions

      t.timestamps
    end
  end
end
