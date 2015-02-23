class AddTitleToReposts < ActiveRecord::Migration
  def change
    add_column :reposts, :title, :string
  end
end
