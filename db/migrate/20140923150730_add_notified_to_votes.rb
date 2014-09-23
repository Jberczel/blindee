class AddNotifiedToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :notified, :boolean
  end
end
