class CreateSitePages < ActiveRecord::Migration
  def change
    create_table :site_pages do |t|
      t.references :user, index: true, null: false
      t.string :short_id, index: true, null: false
      t.references :site, index: true, null: false
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
