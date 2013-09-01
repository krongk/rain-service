class CreatePhoneItems < ActiveRecord::Migration
  def change
    create_table :phone_items do |t|
      t.references :user, index: true
      t.string :mobile_phone, null: false, index: true
      t.string :source_name
      t.string :name
      t.string :city
      t.string :area
      t.string :description
      t.string :is_processed, defualt: 'n'

      t.timestamps
    end
  end
end
