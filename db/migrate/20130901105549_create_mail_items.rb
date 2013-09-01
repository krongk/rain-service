class CreateMailItems < ActiveRecord::Migration
  def change
    create_table :mail_items do |t|
      t.references :user, index: true
      t.string :email, null: false, index: true
      t.string :source_name
      t.string :name
      t.string :city
      t.string :area
      t.string :description
      t.string :is_processed, default: 'n'

      t.timestamps
    end
  end
end
