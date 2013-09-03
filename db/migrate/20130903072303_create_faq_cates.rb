class CreateFaqCates < ActiveRecord::Migration
  def change
    create_table :faq_cates do |t|
      t.integer :typo, null: false, index: true
      t.string :name, null: false, index: true
      t.boolean :is_auth, default: false
    end
  end
end
