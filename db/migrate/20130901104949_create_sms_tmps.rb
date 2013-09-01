class CreateSmsTmps < ActiveRecord::Migration
  def change
    create_table :sms_tmps do |t|
      t.references :user, index: true
      t.string :title, null: false
      t.text :content, null: false
      t.integer :content_size, null: false

      t.timestamps
    end
  end
end
