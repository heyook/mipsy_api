class AddUserIdToReposts < ActiveRecord::Migration
  def change
    add_column :reposts, :user_id, :integer
    add_index :reposts, :user_id
  end
end
