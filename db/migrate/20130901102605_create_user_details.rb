class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.references :user, index: true, null: false
      t.string :contact_name
      t.string :id_card
      t.string :mobile_phone
      t.string :tel_phone
      t.string :qq
      t.string :email
      t.string :website
      t.string :region
      t.string :city
      t.string :district
      t.string :address
      t.string :latitude
      t.string :longitude
      t.string :company_name
      t.string :company_nickname
      t.string :corporator
      t.string :company_reg_no
      t.string :company_reg_code
      t.string :company_keywords
      t.text :company_description
      t.string :fu_gmail_name
      t.string :fu_gmail_pwd
      t.string :fu_qmail_name
      t.string :fu_qmail_pwd
      t.string :fu_user_name
      t.string :fu_user_pwd

      t.timestamps
    end
  end
end
