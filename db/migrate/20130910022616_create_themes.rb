class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name, null: false
      t.string :cate, null: false, default: 'bootswatch'
      t.string :tags
      t.string :templete_image
      t.string :templete_url
      t.string :default_pages, default: "关于, about|产品特色, features|产品列表, portfolio|博客, blog|联系方式, contact|在线帮助, comment|帮助说明, faq"
      t.text :css_url
      t.text :js_url
      t.text :header
      t.text :body
      t.text :footer

      t.timestamps
    end
  end
end
