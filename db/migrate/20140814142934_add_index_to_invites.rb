class AddIndexToInvites < ActiveRecord::Migration
  def change
    add_index :invites, :token
    add_index :invites, :email
    add_index :invites, [:email, :vote_id], unique: true

  end
end
