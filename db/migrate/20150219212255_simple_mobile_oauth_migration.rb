class SimpleMobileOauthMigration < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.integer :identifiable_id
      t.string :identifiable_type
      t.string :image
      t.string :uid,       null: false
      t.string :provider,  null: false
      t.text :info

      t.timestamps null: true
    end
  end
end
