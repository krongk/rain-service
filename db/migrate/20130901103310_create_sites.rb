class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.references :user, index: true
      #site global info
      t.string :contact_name
      t.string :mobile_phone
      t.string :tel_phone
      t.string :qq
      t.string :email
      t.string :website
      t.string :address
      t.string :company_name
      t.string :duoshuo #the account name of http://www.duoshuo.com/
      #site info
      t.string :short_id, index: true, null: false #story the unique short_id
      t.string :title, null: false
      t.string :domain
      t.integer :theme_id, default: 0
      t.text :head
      t.text :header
      t.text :body
      t.text :footer
      t.boolean :is_published, default: false

      t.timestamps
    end
  end
end
