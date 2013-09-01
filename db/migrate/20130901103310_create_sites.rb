class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.references :user, index: true
      t.string :site_name, index: true, null: false
      t.string :site_title, null: false
      t.string :domain
      t.integer :theme_id, null: false
      t.text :head
      t.text :header
      t.text :body
      t.text :footer
      t.boolean :is_published, default: false

      t.timestamps
    end
  end
end
