class CreateKeystores < ActiveRecord::Migration
  def change
    create_table :keystores do |t|
      t.string :key, null: false, index: true
      t.integer :value, null: false, default: 0

    end
  end
end
