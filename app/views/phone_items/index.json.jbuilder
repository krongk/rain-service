json.array!(@phone_items) do |phone_item|
  json.extract! phone_item, :user_id, :mobile_phone, :source_name, :name, :city, :area, :description, :is_processed
  json.url phone_item_url(phone_item, format: :json)
end
