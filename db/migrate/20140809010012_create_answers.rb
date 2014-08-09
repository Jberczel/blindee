class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :vote_id
      t.string :answer

      t.timestamps
    end
  end
end
