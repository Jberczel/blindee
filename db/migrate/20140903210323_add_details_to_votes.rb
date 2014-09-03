class AddDetailsToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :details, :text
  end
end
