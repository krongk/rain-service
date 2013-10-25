class CreatePhoneCalls < ActiveRecord::Migration
  def change
    create_table :phone_calls do |t|
      t.references :user, index: true
      t.string :domain
      t.string :from_ip
      t.string :from_url
      t.string :from_phone
      t.boolean :is_processed
      t.text :note

      t.timestamps
    end
  end
end
