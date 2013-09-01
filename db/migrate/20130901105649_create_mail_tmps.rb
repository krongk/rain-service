class CreateMailTmps < ActiveRecord::Migration
  def change
    create_table :mail_tmps do |t|
      t.references :user, index: true
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
