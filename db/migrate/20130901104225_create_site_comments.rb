class CreateSiteComments < ActiveRecord::Migration
  def change
    create_table :site_comments do |t|
      t.references :site, index: true, null: false
      t.string :name
      t.string :mobile_phone, null: false
      t.string :email, null: false
      t.text :content, null: false
      t.boolean :is_processed, default: false

      t.timestamps
    end
  end
end
