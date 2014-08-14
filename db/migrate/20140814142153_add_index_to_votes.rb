class AddIndexToVotes < ActiveRecord::Migration
  def change
    add_index  :votes, :creator_id
  end
end
