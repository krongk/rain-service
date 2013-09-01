json.array!(@mail_items) do |mail_item|
  json.extract! mail_item, :user_id, :email, :source_name, :name, :city, :area, :description, :is_processed
  json.url mail_item_url(mail_item, format: :json)
end
