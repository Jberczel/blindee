class FixPublicName < ActiveRecord::Migration
  def change
    rename_column :votes, :public, :public_vote
  end
end
