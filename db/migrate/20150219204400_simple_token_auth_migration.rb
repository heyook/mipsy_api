class SimpleTokenAuthMigration < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.integer :token_authenticatable_id,  null: false
      t.string :token_authenticatable_type, null: false
      t.string :access_token,               null: false
      t.datetime :expired_at
      t.datetime :created_at
    end
    add_index :api_keys, :access_token, unique: true
  end
end
