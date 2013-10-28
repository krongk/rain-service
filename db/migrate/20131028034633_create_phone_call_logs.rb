class CreatePhoneCallLogs < ActiveRecord::Migration
  def change
    create_table :phone_call_logs do |t|
      t.references :user, index: true
      t.references :phone_call, index: true
      t.string :status, null: false, defalut: 0
      t.string :billing_count, null: false, defalut: 0

      t.timestamps
    end
  end
end
