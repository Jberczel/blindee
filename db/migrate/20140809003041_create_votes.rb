class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :question
      t.text :choices
      t.integer :creator_id

      t.timestamps
    end
  end
end
