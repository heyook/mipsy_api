class CreateReposts < ActiveRecord::Migration
  def change
    create_table :reposts do |t|
      t.integer :article_id
      t.string :ref_id
      t.string :ref_type

      t.timestamps null: false
    end
    add_index :reposts, :article_id
  end
end
