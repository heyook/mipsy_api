class AddInfoToReposts < ActiveRecord::Migration
  def change
    add_column :reposts, :info, :text
  end
end
