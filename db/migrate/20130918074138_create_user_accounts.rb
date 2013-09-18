class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.references :user, index: true
      t.string :name
      t.string :value
    end
    add_index :user_accounts, [:user_id, :name], :unique => true
  end
end
