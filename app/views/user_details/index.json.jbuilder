json.array!(@user_details) do |user_detail|
  json.extract! user_detail, :user_id, :contact_name, :id_card, :mobile_phone, :tel_phone, :qq, :email, :website, :region, :city, :district, :address, :latitude, :longitude, :company_name, :company_nickname, :corporator, :company_reg_no, :company_keywords, :company_description, :fu_gmail_name, :fu_gmail_pwd, :fu_qmail_name, :fu_qmail_pwd, :fu_user_name, :fu_user_pwd
  json.url user_detail_url(user_detail, format: :json)
end
