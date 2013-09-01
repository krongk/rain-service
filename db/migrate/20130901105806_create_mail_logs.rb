class CreateMailLogs < ActiveRecord::Migration
  def change
    create_table :mail_logs do |t|
      t.references :user, index: true, null: false
      t.references :mail_item, index: true, null: false
      t.references :mail_tmp, index: true, null: false
      t.integer :status, default: 0
      t.integer :billing_count, null: false, default: 0

      t.timestamps
    end
  end
end
