class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.references :user, index: true
      t.string :short_id, index: true, null: false #story the unique short_id
      t.string :title, null: false
      t.string :domain
      t.integer :theme_id, default: 1
      t.text :head
      t.text :header
      t.text :body
      t.text :footer
      t.boolean :is_published, default: false

      t.timestamps
    end
  end
end
