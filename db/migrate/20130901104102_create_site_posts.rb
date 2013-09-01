class CreateSitePosts < ActiveRecord::Migration
  def change
    create_table :site_posts do |t|
      t.references :user, index: true, null: false
      t.references :site, index: true, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.string :key_words
      t.integer :cate_id, default: 0
      t.integer :is_processed, default: 0

      t.timestamps
    end
  end
end
