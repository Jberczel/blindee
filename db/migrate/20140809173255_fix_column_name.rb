class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :invites, :recpient_id, :recipient_id
  end
end
