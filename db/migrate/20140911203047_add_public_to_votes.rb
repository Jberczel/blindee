class AddPublicToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :public, :boolean
  end
end
