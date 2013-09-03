class CreateFaqItems < ActiveRecord::Migration
  def change
    create_table :faq_items do |t|
      t.references :faq_cate, index: true
      t.string :title, null: false, index: true
      t.text :content
      t.text :markeddown_content
    end
  end
end
