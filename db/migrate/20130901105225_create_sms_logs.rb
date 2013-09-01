class CreateSmsLogs < ActiveRecord::Migration
  def change
    create_table :sms_logs do |t|
      t.references :user, index: true
      t.references :phone_item, index: true
      t.references :sms_tmp, index: true
      t.integer :status, default: 0
      t.integer :billing_count, null: false, defalut: 0

      t.timestamps
    end
  end
end
