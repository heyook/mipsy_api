class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :link
      t.string :image_url
      t.string :ref_id
      t.string :ref_type

      t.timestamps null: false
    end
  end
end
